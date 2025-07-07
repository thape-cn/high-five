json.array! ContractBasic::NEED_COMPLETE_BASIC_FIELDS do |field_name|
  next if contract_basic[field_name].blank?

  json.key field_name
  json.key_title I18n.t("contracts.#{field_name}")

  think, value = API::ContractsController.helpers.split_think_value(contract_basic[field_name])
  json.thinking think
  json.result value
end
