class AddUniqueIndexToContractBasic < ActiveRecord::Migration[8.0]
  def change
    add_index :contract_basics, :bpm_id, unique: true
  end
end
