json.array! ContractReview::NEED_COMPLETE_REVIEW_FIELDS do |field_name|
  next if contract_review[field_name].blank?

  json.key field_name
  json.key_title I18n.t("contract_reviews.#{field_name}")

  think, value = API::ContractsController.helpers.split_think_value(contract_review[field_name])
  json.thinking think
  json.result value
end
