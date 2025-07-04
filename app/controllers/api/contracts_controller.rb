module API
  class ContractsController < ActionController::API
    def create
      return render json: {is_success: 403, error_message: "此 API 仅允许内网调用。"}, status: :forbidden unless request.remote_ip.start_with?("172.", "10.") || request.remote_ip == "127.0.0.1"

      render json: {is_success: true}, status: :ok
    end
  end
end
