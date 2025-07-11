class AI::ContractReviewSummaryJob
  include Sidekiq::Job
  include DifyChatInitializable
  include SplitThinkValueHelper

  def perform(contract_review_id)
    contract_review = ContractReview.find(contract_review_id)
    review_summary_dify_key = Rails.application.credentials.dify_review_keys["review_summary"]
    dify_chat = initialize_dify_chat(review_summary_dify_key)

    _, scope_business_value = split_think_value(contract_review.scope_business)
    _, curtain_wall_cert_usage_value = split_think_value(contract_review.curtain_wall_cert_usage)
    _, epc_lead_role_value = split_think_value(contract_review.epc_lead_role)
    _, first_payment_prepayment_value = split_think_value(contract_review.first_payment_prepayment)
    _, fee_adjustment_downward_only_value = split_think_value(contract_review.fee_adjustment_downward_only)
    _, danger_payment_specified_value = split_think_value(contract_review.danger_payment_specified)
    _, prohibited_split_value = split_think_value(contract_review.prohibited_split)
    _, final_payment_rate_value = split_think_value(contract_review.final_payment_rate)
    _, penalty_staff_replacement_value = split_think_value(contract_review.penalty_staff_replacement)
    _, penalty_amount_value = split_think_value(contract_review.penalty_amount)
    _, work_suspension_prohibited_value = split_think_value(contract_review.work_suspension_prohibited)
    _, liability_cap_twice_contract_value = split_think_value(contract_review.liability_cap_twice_contract)
    _, cross_contract_penalty_prohibited_value = split_think_value(contract_review.cross_contract_penalty_prohibited)
    _, liability_clause_keywords_value = split_think_value(contract_review.liability_clause_keywords)

    question = <<~"EOS_QUESTION"
      * #{I18n.t("contract_reviews.scope_business")} 的审查结果：#{scope_business_value}
      * #{I18n.t("contract_reviews.curtain_wall_cert_usage")} 的审查结果：#{curtain_wall_cert_usage_value}
      * #{I18n.t("contract_reviews.epc_lead_role")} 的审查结果：#{epc_lead_role_value}
      * #{I18n.t("contract_reviews.first_payment_prepayment")} 的审查结果：#{first_payment_prepayment_value}
      * #{I18n.t("contract_reviews.fee_adjustment_downward_only")} 的审查结果：#{fee_adjustment_downward_only_value}
      * #{I18n.t("contract_reviews.danger_payment_specified")} 的审查结果：#{danger_payment_specified_value}
      * #{I18n.t("contract_reviews.prohibited_split")} 的审查结果：#{prohibited_split_value}
      * #{I18n.t("contract_reviews.final_payment_rate")} 的审查结果：#{final_payment_rate_value}
      * #{I18n.t("contract_reviews.penalty_staff_replacement")} 的审查结果：#{penalty_staff_replacement_value}
      * #{I18n.t("contract_reviews.penalty_amount")} 的审查结果：#{penalty_amount_value}
      * #{I18n.t("contract_reviews.work_suspension_prohibited")} 的审查结果：#{work_suspension_prohibited_value}
      * #{I18n.t("contract_reviews.liability_cap_twice_contract")} 的审查结果：#{liability_cap_twice_contract_value}
      * #{I18n.t("contract_reviews.cross_contract_penalty_prohibited")} 的审查结果：#{cross_contract_penalty_prohibited_value}
      * #{I18n.t("contract_reviews.liability_clause_keywords")} 的审查结果：#{liability_clause_keywords_value}
    EOS_QUESTION

    response = dify_chat.ask question
    contract_review.update_attribute("review_summary", response.content)
  rescue => e
    Rails.logger.error "Error in ContractReviewSummaryJob with #{contract_review.id}: #{e.message}"
    raise e
  end
end
