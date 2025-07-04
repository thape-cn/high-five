class AddBpmIdToContractBasic < ActiveRecord::Migration[8.0]
  def change
    add_column :contract_basics, :bpm_id, :string
  end
end
