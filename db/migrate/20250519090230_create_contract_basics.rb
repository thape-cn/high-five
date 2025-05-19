class CreateContractBasics < ActiveRecord::Migration[8.0]
  def change
    create_table :contract_basics do |t|
      t.string :upload_file_id, comment: "Dify 上传完毕后拿到的文件 ID"
      t.string :contract_type, comment: "合同类型"
      t.string :contract_nature, comment: "合同性质"
      t.string :east_boundary, comment: "东至"
      t.string :south_boundary, comment: "南至"
      t.string :west_boundary, comment: "西至"
      t.string :north_boundary, comment: "北至"
      t.string :contract_name, comment: "合同名称"
      t.string :project_land_use_nature, comment: "项目用地性质"
      t.string :currency, limit: 10, comment: "币种"
      t.decimal :contract_amount, precision: 18, scale: 2, comment: "合同金额"
      t.decimal :split_contract_amount, precision: 18, scale: 2, comment: "切分合同金额"
      t.decimal :actual_contract_amount, precision: 18, scale: 2, comment: "实际合同额"
      t.string :party_a, comment: "甲方"
      t.string :party_b, comment: "乙方"
      t.string :scale_type, comment: "规模类型"
      t.decimal :scale_area, precision: 18, scale: 2, comment: "规模面积"
      t.string :beneficiary_bank_account, comment: "收款银行账户"
      t.string :beneficiary_bank, comment: "收款开户行"
      t.boolean :is_epc, null: true, comment: "是否EPC"
      t.boolean :is_design_general_contractor, null: true, comment: "是否设计总承包"
      t.string :project_tag, comment: "项目标签"
      t.string :quotation_method, comment: "报价方式"
      t.decimal :construction_and_installation_fee, precision: 18, scale: 2, comment: "工程建安费"
      t.decimal :discount_rate, precision: 5, scale: 4, comment: "下浮系数"
      t.string :developer_name, comment: "建设方名称"
      t.string :developer_type, comment: "建设方类型"

      t.timestamps
    end
  end
end
