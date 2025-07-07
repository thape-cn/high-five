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

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.east_boundary)
  json.east_boundary_think think
  json.east_boundary value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.south_boundary)
  json.south_boundary_think think
  json.south_boundary value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.west_boundary)
  json.west_boundary_think think
  json.west_boundary value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.north_boundary)
  json.north_boundary_think think
  json.north_boundary value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.contract_name)
  json.contract_name_think think
  json.contract_name value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.project_land_use_nature)
  json.project_land_use_nature_think think
  json.project_land_use_nature value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.currency)
  json.currency_think think
  json.currency value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.contract_amount)
  json.contract_amount_think think
  json.contract_amount value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.split_contract_amount)
  json.split_contract_amount_think think
  json.split_contract_amount value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.actual_contract_amount)
  json.actual_contract_amount_think think
  json.actual_contract_amount value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.party_a)
  json.party_a_think think
  json.party_a value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.party_b)
  json.party_b_think think
  json.party_b value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.scale_type)
  json.scale_type_think think
  json.scale_type value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.scale_area)
  json.scale_area_think think
  json.scale_area value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.beneficiary_bank_account)
  json.beneficiary_bank_account_think think
  json.beneficiary_bank_account value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.beneficiary_bank)
  json.beneficiary_bank_think think
  json.beneficiary_bank value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.is_epc)
  json.is_epc_think think
  json.is_epc value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.is_design_general_contractor)
  json.is_design_general_contractor_think think
  json.is_design_general_contractor value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.project_tag)
  json.project_tag_think think
  json.project_tag value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.quotation_method)
  json.quotation_method_think think
  json.quotation_method value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.construction_and_installation_fee)
  json.construction_and_installation_fee_think think
  json.construction_and_installation_fee value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.discount_rate)
  json.discount_rate_think think
  json.discount_rate value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.developer_name)
  json.developer_name_think think
  json.developer_name value

  think, value = API::ContractsController.helpers.split_think_value(@contract_basic.developer_type)
  json.developer_type_think think
  json.developer_type value
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
