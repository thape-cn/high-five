class ContractReviewSummary
  def on_success(status, options)
    contract_review_id = options["contract_review_id"]
    Rails.logger.info "Contract review id: #{contract_review_id} succeeded."
    AI::ContractReviewSummaryJob.perform_async(contract_review_id)
  end
end
