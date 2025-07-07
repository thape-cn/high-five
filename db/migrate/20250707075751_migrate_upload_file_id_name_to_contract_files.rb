class MigrateUploadFileIdNameToContractFiles < ActiveRecord::Migration[8.0]
  def change
    ContractBasic.all.each do |basic|
      basic.contract_files.create(upload_file_id: basic.upload_file_id, upload_filename: basic.upload_filename)
    end
    remove_column :contract_basics, :upload_file_id, type: :string
    remove_column :contract_basics, :upload_filename, type: :string
  end
end
