json.is_success true
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

if @contract_review.present?
  json.contract_review do
    json.partial! "contract_review", locals: {contract_review: @contract_review}
  end
else
  json.contract_review nil
end
