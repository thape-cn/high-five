module Admin
  class ContractsController < BaseController
    def new
      @contract_basic = authorize ContractBasic.new
      render layout: false
    end

    def create
      contract_params[:file]
      authorize ContractBasic.create(upload_file_id: "upload_file_id")
    end

    private

    def contract_params
      params.permit(:file)
    end
  end
end
