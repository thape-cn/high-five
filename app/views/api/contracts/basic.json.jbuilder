json.is_success true
json.error_message nil
json.contract_id @contract_basic.id
json.bpm_id @contract_basic.bpm_id
json.upload_file_ids @contract_basic.contract_files.collect(&:upload_file_id)
json.upload_filenames @contract_basic.contract_files.collect(&:upload_filename)
json.contract_basic do
  json.partial! "contract_basic", locals: {contract_basic: @contract_basic}
end
