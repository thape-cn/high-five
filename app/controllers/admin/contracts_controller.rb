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
      response = dify_chat.upload_document(file)
      if response.status == 201
        upload_file_id = response.body[:id]
        upload_filename = response.body[:name]
        authorize ContractBasic.create(upload_file_id:, upload_filename:)
      end
    end

    def show
      @contract_basic = authorize ContractBasic.find_by(upload_file_id: params[:id])
    end

    def invoke_ai
      @field_name = params["field_name"]
      @begin_time = Time.zone.now
      field_dify_key = Rails.application.credentials.dify_basic_keys[@field_name]
      dify_chat = initialize_dify_chat(field_dify_key)
      @response = dify_chat.ask "合同数据录入", with: @contract_basic.upload_file_id
      Rails.logger.info "log in invoke_ai #{@field_name} with #{@contract_basic.upload_file_id}: #{@response.content}"
      @contract_basic.update_attribute(@field_name, @response.content)
      render layout: false
    rescue => exception
      Rails.logger.info "exception in invoke_ai #{field_name} with #{@contract_basic.upload_file_id}: #{exception}"
      render layout: false
    end

    def confirm_batch_ai_filling_basic
      render layout: false
    end

    def batch_ai_filling_basic
      ContractBasic::NEED_COMPLETE_BASIC_FIELDS.each do |field_name|
        next if @contract_basic[field_name].present?

        AI::ContractBasicFillingJob.perform_async(@contract_basic.id, field_name.to_s)
      end
    end

    def confirm_batch_ai_filling_review
      render layout: false
    end

    def batch_ai_filling_review
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
