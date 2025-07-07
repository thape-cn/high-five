# 设计范围
think, value = API::ContractsController.helpers.split_think_value(contract_review.scope_business)
json.scope_business_think think
json.scope_business value

think, value = API::ContractsController.helpers.split_think_value(contract_review.curtain_wall_cert_usage)
json.curtain_wall_cert_usage_think think
json.curtain_wall_cert_usage value

think, value = API::ContractsController.helpers.split_think_value(contract_review.epc_lead_role)
json.epc_lead_role_think think
json.epc_lead_role value

# 设计费相关
think, value = API::ContractsController.helpers.split_think_value(contract_review.first_payment_prepayment)
json.first_payment_prepayment_think think
json.first_payment_prepayment value

think, value = API::ContractsController.helpers.split_think_value(contract_review.fee_adjustment_downward_only)
json.fee_adjustment_downward_only_think think
json.fee_adjustment_downward_only value

think, value = API::ContractsController.helpers.split_think_value(contract_review.danger_payment_specified)
json.danger_payment_specified_think think
json.danger_payment_specified value

think, value = API::ContractsController.helpers.split_think_value(contract_review.prohibited_split)
json.prohibited_split_think think
json.prohibited_split value

think, value = API::ContractsController.helpers.split_think_value(contract_review.final_payment_rate)
json.final_payment_rate_think think
json.final_payment_rate value

# 乙方权利
think, value = API::ContractsController.helpers.split_think_value(contract_review.penalty_staff_replacement)
json.penalty_staff_replacement_think think
json.penalty_staff_replacement value

think, value = API::ContractsController.helpers.split_think_value(contract_review.penalty_amount)
json.penalty_amount_think think
json.penalty_amount value

think, value = API::ContractsController.helpers.split_think_value(contract_review.work_suspension_prohibited)
json.work_suspension_prohibited_think think
json.work_suspension_prohibited value

# 违约责任
think, value = API::ContractsController.helpers.split_think_value(contract_review.liability_cap_twice_contract)
json.liability_cap_twice_contract_think think
json.liability_cap_twice_contract value

think, value = API::ContractsController.helpers.split_think_value(contract_review.cross_contract_penalty_prohibited)
json.cross_contract_penalty_prohibited_think think
json.cross_contract_penalty_prohibited value

think, value = API::ContractsController.helpers.split_think_value(contract_review.liability_clause_keywords)
json.liability_clause_keywords_think think
json.liability_clause_keywords value
