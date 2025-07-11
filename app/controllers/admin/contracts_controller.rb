module Admin
  class ContractsController < BaseController
    include DifyChatInitializable

    before_action :set_contract_basic, only: %i[invoke_ai
      confirm_batch_ai_filling_basic batch_ai_filling_basic
      confirm_batch_ai_filling_review batch_ai_filling_review
      confirm_destroy destroy]

    def new
      @contract_basic = authorize ContractBasic.new
      render layout: false
    end

    def create
      file = contract_params[:file]
      dify_chat = initialize_dify_chat
      response = dify_chat.provider.upload_document(file)
      if response.status == 201
        upload_file_id = response.body[:id]
        upload_filename = response.body[:name]
        bpm_id = "bpm_id_#{upload_file_id}"
        contract_basic = ContractBasic.create(bpm_id:)
        contract_basic.contract_files.create(upload_file_id:, upload_filename:)
        contract_basic.create_contract_review
        authorize contract_basic
      end
    end

    def show
      @contract_basic = authorize ContractBasic.find_by(bpm_id: params[:id])
    end

    def invoke_ai
      field_name = params["field_name"]
      case params["category"]
      when "basic"
        AI::ContractBasicFillingJob.perform_async(@contract_basic.id, field_name.to_s)
      end
      head :no_content
    end

    def confirm_batch_ai_filling_basic
      render layout: false
    end

    def batch_ai_filling_basic
      batch = Sidekiq::Batch.new
      batch.description = "Batch filling contract basic id: #{@contract_basic.id}"
      batch.jobs do
        ContractBasic::NEED_COMPLETE_BASIC_FIELDS.each do |field_name|
          next if @contract_basic[field_name].present?

          AI::ContractBasicFillingJob.perform_async(@contract_basic.id, field_name.to_s)
        end
      end
    end

    def confirm_batch_ai_filling_review
      render layout: false
    end

    def batch_ai_filling_review
      contract_review = @contract_basic.contract_review
      batch = Sidekiq::Batch.new
      batch.description = "Batch filling contract review id: #{contract_review.id}"
      # this will call "ContractReviewSummary.new.on_success"
      batch.on(:success, ContractReviewSummary, "contract_review_id" => contract_review.id)
      batch.jobs do
        ContractReview::NEED_COMPLETE_REVIEW_FIELDS.each do |field_name|
          next if contract_review[field_name].present?

          AI::ContractReviewFillingJob.perform_async(contract_review.id, field_name.to_s)
        end
      end
    end

    def confirm_destroy
      render layout: false
    end

    def destroy
      return unless @contract_basic.present?
      @contract_basic.destroy
    end

    private

    def set_contract_basic
      @contract_basic = authorize ContractBasic.find(params[:id])
    end

    def contract_params
      params.permit(:file, :authenticity_token, :commit)
    end
  end
end
