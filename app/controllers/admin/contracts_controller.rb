module Admin
  class ContractsController < BaseController
    before_action :set_contract_basic, only: %i[invoke_ai destroy confirm_destroy]

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

    def invoke_ai
      @field_name = params["field_name"]
      @begin_time = Time.zone.now
      field_dify_key = Rails.application.credentials.dify_keys[@field_name]
      dify_chat = initialize_dify_chat(field_dify_key)
      @response = dify_chat.ask "合同数据录入", with: @contract_basic.upload_file_id
      Rails.logger.info "log in invoke_ai #{@field_name} with #{@contract_basic.upload_file_id}: #{@response.content}"
      @contract_basic.update_attribute(@field_name, @response.content)
      render layout: false
    rescue => exception
      Rails.logger.info "exception in invoke_ai #{field_name} with #{@contract_basic.upload_file_id}: #{exception}"
      render layout: false
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

    def initialize_dify_chat(api_key = Rails.application.credentials.dify_api_key)
      dify_chat = RubyLLM.chat(model: "dify-api", provider: :dify, assume_model_exists: true)
      dify_chat.with_context(RubyLLM.context do |config|
        config.dify_api_base = Rails.application.credentials.dify_base_url
        config.dify_api_key = api_key
      end)
      dify_chat
    end
  end
end
