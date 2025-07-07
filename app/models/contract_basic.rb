class ContractBasic < ApplicationRecord
  has_one :contract_review, dependent: :destroy
  validates :bpm_id, presence: true, uniqueness: true

  NEED_COMPLETE_BASIC_FIELDS = [
    :contract_type,
    :contract_nature,
    :east_boundary,
    :south_boundary,
    :west_boundary,
    :north_boundary,
    :contract_name,
    :project_land_use_nature,
    :currency,
    :contract_amount,
    :split_contract_amount,
    :actual_contract_amount,
    :party_a,
    :party_b,
    :scale_type,
    :scale_area,
    :beneficiary_bank_account,
    :beneficiary_bank,
    :is_epc,
    :is_design_general_contractor,
    :project_tag,
    :quotation_method,
    :construction_and_installation_fee,
    :discount_rate,
    :developer_name,
    :developer_type
  ].freeze

  def complete_field_count
    NEED_COMPLETE_BASIC_FIELDS.count { |field| self[field].present? }
  end
end
