class CreateContractFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :contract_files do |t|
      t.string :upload_file_id
      t.string :upload_filename
      t.references :contract_basic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
