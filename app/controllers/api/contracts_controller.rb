module API
  class ContractsController < ActionController::Base
    include DifyChatInitializable

    before_action :check_internal_ip, only: [:update, :show, :basic, :review]
    before_action :load_contract, only: [:show, :basic, :review]

    def update
      bpm_id = params[:id]
      file = contract_params[:file]
      filename = contract_params[:filename]

      if bpm_id.blank?
        return render json: {is_success: false, error_message: "ID 不能为空"}, status: :bad_request
      end

      if file.blank?
        return render json: {is_success: false, error_message: "文件不能为空"}, status: :bad_request
      end

      dify_chat = initialize_dify_chat
      response = dify_chat.provider.upload_document(file)

      if response.status == 201
        upload_file_id = response.body[:id]
        upload_filename = filename.presence || response.body[:name]

        contract_basic = ContractBasic.find_or_create_by(bpm_id: bpm_id) do |cb|
          cb.upload_file_id = upload_file_id
          cb.upload_filename = upload_filename
        end
        contract_basic.upload_file_id = upload_file_id
        contract_basic.upload_filename = upload_filename
        contract_basic.save
        contract_basic.create_contract_review # always create new contract_review after file changed

        render json: {
          is_success: true,
          bpm_id: contract_basic.bpm_id,
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

    def contract_details
      render action_name
    end
    alias show contract_details
    alias basic contract_details
    alias review contract_details

    private

    def check_internal_ip
      return if valid_ip?
      render json: { is_success: false, error_message: "此 API 仅允许内网调用。" }, status: :forbidden
    end

    def load_contract
      @contract_basic = ContractBasic.find_by(bpm_id: params[:id])
      @contract_review = @contract_basic.contract_review
      return if @contract_basic.present?
      render json: { is_success: false, error_message: "bpm_id 不能为空" }, status: :bad_request
    end

    def valid_ip?
      ip = request.remote_ip
      ip.start_with?("172.", "10.") || ip.in?(["127.0.0.1", "::1"])
    end

    def contract_params
      params.permit(:id, :file, :filename)
    end
  end
end
