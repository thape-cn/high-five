module Admin
  class ContractsController < BaseController
    def new
      @contract_basic = authorize ContractBasic.new
      render layout: false
    end

    def create
      file = contract_params[:file]
      chat = RubyLLM.chat(model: "dify-api", provider: :dify, assume_model_exists: true)
      response = chat.upload_document(file)
      if response.status == 201
        upload_file_id = response.body[:id]
        authorize ContractBasic.create(upload_file_id: upload_file_id)
      end
    end

    private

    def contract_params
      params.permit(:file, :authenticity_token, :commit)
    end
  end
end
