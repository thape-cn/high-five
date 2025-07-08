class AI::ContractReviewFillingJob
  include Sidekiq::Job
  include DifyChatInitializable

  def perform(contract_review_id, field_name)
    contract_review = ContractReview.find(contract_review_id)
    field_dify_key = Rails.application.credentials.dify_review_keys[field_name.to_sym]
    dify_chat = initialize_dify_chat(field_dify_key)

    response = dify_chat.ask "合同审查", with: contract_review.contract_basic.support_files.collect(&:upload_file_id)
    contract_review.update_attribute(field_name, response.content)
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error "ContractReview not found with id: #{contract_review_id}"
    raise e
  rescue => e
    Rails.logger.error "Error in ContractReviewFillingJob #{field_name} with #{contract_review_id}: #{e.message}"
    raise e
  end
end
