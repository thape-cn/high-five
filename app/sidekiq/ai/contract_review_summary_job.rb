class AI::ContractReviewSummaryJob
  include Sidekiq::Job
  include DifyChatInitializable

  def perform(contract_review_id, field_name)
    contract_review = ContractReview.find(contract_review_id)
  rescue => e
    Rails.logger.error "Error in ContractReviewSummaryJob with #{contract_review.id}: #{e.message}"
    raise e
  end
end
