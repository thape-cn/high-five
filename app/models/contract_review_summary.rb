class ContractReviewSummary
  def on_success(status, options)
    contract_review_id = options["contract_review_id"]
    Rails.logger.info "Contract review id: #{contract_review_id} succeeded."
  end
end
