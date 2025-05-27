class AI::ContractBasicFillingJob
  include Sidekiq::Job

  def perform(contract_basic_id, field_name)
    contract_basic = ContractBasic.find(contract_basic_id)
    field_dify_key = Rails.application.credentials.dify_keys[field_name]
    dify_chat = initialize_dify_chat(field_dify_key)

    response = dify_chat.ask "合同数据录入", with: contract_basic.upload_file_id
    Rails.logger.info "log in ContractBasicFillingJob #{field_name} with #{contract_basic.upload_file_id}: #{response.content}"

    contract_basic.update_attribute(field_name, response.content)
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "ContractBasic not found with id: #{contract_basic_id}"
    raise e
  rescue => e
    Rails.logger.error "Error in ContractBasicFillingJob #{field_name} with #{contract_basic_id}: #{e.message}"
    raise e
  end

  private

  def initialize_dify_chat(api_key = Rails.application.credentials.dify_api_key)
    dify_chat = RubyLLM.chat(model: "dify-api", provider: :dify, assume_model_exists: true)
    dify_chat.with_context(RubyLLM.context do |config|
      config.dify_api_base = Rails.application.credentials.dify_base_url
      config.dify_api_key = api_key
    end)
    dify_chat
  end
end
