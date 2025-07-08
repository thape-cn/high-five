json.array! contract_basic.contract_files do |contract_file|
  json.upload_file_id contract_file.upload_file_id
  json.upload_filename contract_file.upload_filename
  json.file_id contract_file.file_id
  json.attachment_address contract_file.attachment_address
  json.enclosure_name contract_file.enclosure_name
end
