module API
  class ContractsController < ActionController::Base
    include DifyChatInitializable
    skip_before_action :verify_authenticity_token
    before_action :check_internal_ip, only: [:update, :show, :basic, :review]
    before_action :load_contract, only: [:show, :basic, :review]

    def update
      bpm_id = params[:id]
      # Handle both top-level files_info and nested contract[:files_info]
      files_info = contract_params[:files_info].presence || contract_params.dig(:contract, :files_info)

      if bpm_id.blank?
        return render json: {is_success: false, error_message: "ID 不能为空"}, status: :bad_request
      end

      if files_info.blank?
        return render json: {is_success: false, error_message: "files_info 不能为空"}, status: :bad_request
      end
      contract_basic = ContractBasic.find_or_create_by(bpm_id: bpm_id)
      contract_basic.contract_files.destroy_all
      files_info.each do |file_url|
        contract_file = contract_basic.contract_files.create(file_id: file_url["ID"], attachment_address: file_url["ATTACHMENTADDRESS"], enclosure_name: file_url["ENCLOSURENAME"])
        attachment_url = file_url["ATTACHMENTADDRESS"]
        file_extension = attachment_url.split("/").last.split("?").last.split(".").last
        # Download the remote file to a temporary location so that we can
        # provide an IO-like object to `upload_document` (passing the raw
        # Faraday::Response previously caused a type error).
        remote_response = Faraday.get(attachment_url)
        tempfile = Tempfile.new([file_url["ENCLOSURENAME"].to_s, file_extension])
        tempfile.binmode
        tempfile.write(remote_response.body)
        tempfile.rewind

        dify_chat = initialize_dify_chat
        response = dify_chat.provider.upload_document(tempfile)

        # Ensure the tempfile is removed after the upload attempt
        tempfile.close!

        if response.status == 201
          upload_file_id = response.body[:id]
          upload_filename = "#{file_url["ENCLOSURENAME"]}.#{file_extension}"
          contract_file.update(upload_file_id:, upload_filename:)
        end
      end
      contract_basic.create_contract_review # always create new contract_review after file changed
      contract_basic.touch
      render json: {
        is_success: true,
        bpm_id: contract_basic.bpm_id,
        contract_id: contract_basic.id
      }, status: :created
    rescue => e
      Rails.logger.error "API contract create/update error: #{e.message}"
      render json: {is_success: false, error_message: "服务器内部错误"}, status: :internal_server_error
    end

    def contract_details
      render action_name
    end
    alias_method :show, :contract_details
    alias_method :basic, :contract_details
    alias_method :review, :contract_details

    private

    def check_internal_ip
      return if valid_ip?
      render json: {is_success: false, error_message: "此 API 仅允许内网调用。"}, status: :forbidden
    end

    def load_contract
      @contract_basic = ContractBasic.find_by(bpm_id: params[:id])
      @contract_review = @contract_basic.contract_review
      return if @contract_basic.present?
      render json: {is_success: false, error_message: "bpm_id 不能为空"}, status: :bad_request
    end

    def valid_ip?
      ip = request.remote_ip
      ip.start_with?("172.", "10.") || ip.in?(["127.0.0.1", "::1"])
    end

    def contract_params
      params.permit(:id, files_info: [:SALESCONTRACTID, :ID, :ENCLOSURENAME, :ATTACHMENTADDRESS, :UPLOADTIME], contract: {files_info: [:SALESCONTRACTID, :ID, :ENCLOSURENAME, :ATTACHMENTADDRESS, :UPLOADTIME]})
    end
  end
end
