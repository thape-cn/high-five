json.is_success(@contract_basic.complete_field_count == ContractBasic::NEED_COMPLETE_BASIC_FIELDS.count)
json.error_message nil
json.contract_id @contract_basic.id
json.bpm_id @contract_basic.bpm_id
json.updated_at @contract_basic.updated_at
json.contract_files do
  json.partial! "contract_file", locals: {contract_basic: @contract_basic}
end
json.contract_basic do
  json.partial! "contract_basic", locals: {contract_basic: @contract_basic}
end
