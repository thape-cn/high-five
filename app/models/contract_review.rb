class ContractReview < ApplicationRecord
  belongs_to :contract_basic

  NEED_COMPLETE_REVIEW_FIELDS = [
    :scope_business,
    :curtain_wall_cert_usage,
    :epc_lead_role,
    :first_payment_prepayment,
    :fee_adjustment_downward_only,
    :danger_payment_specified,
    :prohibited_split,
    :final_payment_rate,
    :penalty_staff_replacement,
    :penalty_amount,
    :work_suspension_prohibited,
    :liability_cap_twice_contract,
    :cross_contract_penalty_prohibited,
    :liability_clause_keywords
  ].freeze

  def complete_field_count
    NEED_COMPLETE_REVIEW_FIELDS.count { |field| self[field].present? }
  end
end
