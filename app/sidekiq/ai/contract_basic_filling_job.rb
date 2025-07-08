class AI::ContractBasicFillingJob
  include ActionView::RecordIdentifier
  include ActionView::Helpers::TagHelper
  include Sidekiq::Job
  include DifyChatInitializable
  include SplitThinkValueHelper

  def perform(contract_basic_id, field_name)
    contract_basic = ContractBasic.find(contract_basic_id)
    field_dify_key = Rails.application.credentials.dify_basic_keys[field_name.to_sym]
    dify_chat = initialize_dify_chat(field_dify_key)

    response = dify_chat.ask "合同数据录入", with: contract_basic.support_files.collect(&:upload_file_id) do |chunk|
      ActionCable.server.broadcast "llm_channel", {id: dom_id(contract_basic, field_name), content: chunk.content}
    end
    think, value = split_think_value(response.content)
    ActionCable.server.broadcast "llm_channel", {command: "replace", id: dom_id(contract_basic, field_name), html:
      content_tag(:span, value,
        id: dom_id(contract_basic, field_name),
        data: {"coreui-container": "body", "coreui-toggle": "popover", "coreui-placement": "top", "coreui-content": think},
        class: "think_value")}
    contract_basic.update_attribute(field_name, response.content)
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "ContractBasic not found with id: #{contract_basic_id}"
    raise e
  rescue => e
    Rails.logger.error "Error in ContractBasicFillingJob #{field_name} with #{contract_basic_id}: #{e.message}"
    raise e
  end
end
