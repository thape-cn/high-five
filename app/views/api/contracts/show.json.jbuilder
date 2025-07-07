json.is_success true
json.error_message nil
json.contract_basic do
  json.bpm_id @contract_basic.bpm_id
  json.upload_file_id @contract_basic.upload_file_id
  json.upload_filename @contract_basic.upload_filename

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.contract_type)
  json.contract_type_think think
  json.contract_type value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.contract_nature)
  json.contract_nature_think think
  json.contract_nature value

  json.east_boundary @contract_basic.east_boundary
  json.south_boundary @contract_basic.south_boundary
  json.west_boundary @contract_basic.west_boundary
  json.north_boundary @contract_basic.north_boundary
  json.contract_name @contract_basic.contract_name
  json.project_land_use_nature @contract_basic.project_land_use_nature
  json.currency @contract_basic.currency
  json.contract_amount @contract_basic.contract_amount
  json.split_contract_amount @contract_basic.split_contract_amount
  json.actual_contract_amount @contract_basic.actual_contract_amount
  json.party_a @contract_basic.party_a
  json.party_b @contract_basic.party_b
  json.scale_type @contract_basic.scale_type
  json.scale_area @contract_basic.scale_area
  json.beneficiary_bank_account @contract_basic.beneficiary_bank_account
  json.beneficiary_bank @contract_basic.beneficiary_bank
  json.is_epc @contract_basic.is_epc
  json.is_design_general_contractor @contract_basic.is_design_general_contractor
  json.project_tag @contract_basic.project_tag
  json.quotation_method @contract_basic.quotation_method
  json.construction_and_installation_fee @contract_basic.construction_and_installation_fee
  json.discount_rate @contract_basic.discount_rate
  json.developer_name @contract_basic.developer_name
  json.developer_type @contract_basic.developer_type
end

if @contract_review.present?
  json.contract_review do
    # 设计范围
    think, value = API::ContractsController.helpers.split_think_value(@contract_review.scope_business)
    json.scope_business_think think
    json.scope_business value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.curtain_wall_cert_usage)
    json.curtain_wall_cert_usage_think think
    json.curtain_wall_cert_usage value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.epc_lead_role)
    json.epc_lead_role_think think
    json.epc_lead_role value

    # 设计费相关
    think, value = API::ContractsController.helpers.split_think_value(@contract_review.first_payment_prepayment)
    json.first_payment_prepayment_think think
    json.first_payment_prepayment value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.fee_adjustment_downward_only)
    json.fee_adjustment_downward_only_think think
    json.fee_adjustment_downward_only value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.danger_payment_specified)
    json.danger_payment_specified_think think
    json.danger_payment_specified value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.prohibited_split)
    json.prohibited_split_think think
    json.prohibited_split value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.final_payment_rate)
    json.final_payment_rate_think think
    json.final_payment_rate value

    # 乙方权利
    think, value = API::ContractsController.helpers.split_think_value(@contract_review.penalty_staff_replacement)
    json.penalty_staff_replacement_think think
    json.penalty_staff_replacement value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.penalty_amount)
    json.penalty_amount_think think
    json.penalty_amount value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.work_suspension_prohibited)
    json.work_suspension_prohibited_think think
    json.work_suspension_prohibited value

    # 违约责任
    think, value = API::ContractsController.helpers.split_think_value(@contract_review.liability_cap_twice_contract)
    json.liability_cap_twice_contract_think think
    json.liability_cap_twice_contract value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.cross_contract_penalty_prohibited)
    json.cross_contract_penalty_prohibited_think think
    json.cross_contract_penalty_prohibited value

    think, value = API::ContractsController.helpers.split_think_value(@contract_review.liability_clause_keywords)
    json.liability_clause_keywords_think think
    json.liability_clause_keywords value
  end
else
  json.contract_review nil
end
