json.is_success true
json.error_message nil
json.contract_id @contract_basic.id
json.bpm_id @contract_basic.bpm_id
json.upload_file_id @contract_basic.upload_file_id
json.upload_filename @contract_basic.upload_filename
json.contract_basic do
  json.partial! "contract_basic", locals: {contract_basic: @contract_basic}
end

if @contract_review.present?
  json.contract_review do
    json.partial! "contract_review", locals: {contract_review: @contract_review}
  end
else
  json.contract_review nil
end
