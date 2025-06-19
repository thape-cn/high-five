class AI::ContractBasicFillingJob
  include ActionView::RecordIdentifier
  include Sidekiq::Job
  include DifyChatInitializable

  def perform(contract_basic_id, field_name)
    contract_basic = ContractBasic.find(contract_basic_id)
    field_dify_key = Rails.application.credentials.dify_basic_keys[field_name.to_sym]
    dify_chat = initialize_dify_chat(field_dify_key)

    response = dify_chat.ask "合同数据录入", with: contract_basic.upload_file_id do |chunk|
      ActionCable.server.broadcast "llm_channel", {id: dom_id(contract_basic, field_name), content: chunk.content}
    end
    Rails.logger.info "log in ContractBasicFillingJob #{field_name} with #{contract_basic.upload_file_id}: #{response.content}"

    contract_basic.update_attribute(field_name, response.content)
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "ContractBasic not found with id: #{contract_basic_id}"
    raise e
  rescue => e
    Rails.logger.error "Error in ContractBasicFillingJob #{field_name} with #{contract_basic_id}: #{e.message}"
    raise e
  end
end
