module API
  class ContractsController < ActionController::API
    include DifyChatInitializable

    def create
      return render json: {is_success: false, error_message: "此 API 仅允许内网调用。"}, status: :forbidden unless request.remote_ip.start_with?("172.", "10.") || request.remote_ip == "127.0.0.1"

      begin
        file = contract_params[:file]
        filename = contract_params[:filename]

        if file.blank?
          return render json: {is_success: false, error_message: "文件不能为空"}, status: :bad_request
        end

        dify_chat = initialize_dify_chat
        response = dify_chat.provider.upload_document(file)

        if response.status == 201
          upload_file_id = response.body[:id]
          upload_filename = filename.presence || response.body[:name]

          contract_basic = ContractBasic.create(
            upload_file_id: upload_file_id,
            upload_filename: upload_filename
          )

          render json: {
            is_success: true,
            contract_id: contract_basic.id,
            upload_file_id: upload_file_id,
            upload_filename: upload_filename
          }, status: :created
        else
          render json: {is_success: false, error_message: "文件上传失败"}, status: :unprocessable_entity
        end
      rescue => e
        Rails.logger.error "API contract creation error: #{e.message}"
        render json: {is_success: false, error_message: "服务器内部错误"}, status: :internal_server_error
      end
    end

    private

    def contract_params
      params.permit(:file, :filename)
    end
  end
end
