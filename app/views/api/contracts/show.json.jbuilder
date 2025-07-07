json.is_success true
json.error_message nil
json.contract_basic do
  json.bpm_id @contract_basic.bpm_id
end
json.contract_review do
  think, value = API::ContractsController.helpers.split_think_value(@contract_review.liability_clause_keywords)
  json.liability_clause_keywords_think think
  json.liability_clause_keywords value
end
