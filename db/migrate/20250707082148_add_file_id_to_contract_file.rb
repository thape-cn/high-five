class AddFileIdToContractFile < ActiveRecord::Migration[8.0]
  def change
    change_column_comment :contract_files, :upload_file_id, "Dify 上传完毕后拿到的文件 ID"
    change_column_comment :contract_files, :upload_filename, "Dify 上传的文件名"
    add_column :contract_files, :file_id, :string, comment: "来自BPM的File ID"
    add_column :contract_files, :attachment_address, :string, comment: "来自BPM的附件地址"
    add_column :contract_files, :enclosure_name, :string, comment: "来自BPM的文件名"
  end
end
