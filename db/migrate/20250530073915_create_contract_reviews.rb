class CreateContractReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :contract_reviews do |t|
      t.references :contract_basic, null: false, foreign_key: true
      # 设计范围
      t.string :scope_business, comment: "岩土工程设计,市政工程,交通工程设计,勘察,以上都不包含"
      t.string :curtain_wall_cert_usage, comment: "幕墙资质使用天华资质备案"
      t.string :epc_lead_role, comment: "EPC总牵头人"

      # 设计费相关
      t.string :first_payment_prepayment, comment: "收款条件第一笔是否为预付款"
      t.string :fee_adjustment_downward_only, comment: "是否有 设计费只调减不调增 条款"
      t.string :danger_payment_specified, comment: "商业承兑汇票,有追索权的保理,抵房,无追索权的保理,以上都不包含"
      t.string :prohibited_split, comment: "是否违反以下条款：对于大型开发项目或多地块项目，施工图或总包项目要在合同中约定分期开发、分期结算"
      t.string :final_payment_rate, comment: "尾款：施工图审批通过后或立面控制手册完成后收款比例"

      # 乙方权利
      t.string :penalty_staff_replacement, comment: "人员更换罚款"
      t.string :penalty_amount, comment: "罚款金额"
      t.string :work_suspension_prohibited, comment: "禁止无论何种情况下上海天华暂停工作"

      # 违约责任
      t.string :liability_cap_twice_contract, comment: "违约责任应严格限制在本合同总额的2倍，严禁将违约责任的金额与该项目投资总额、施工合同金额和业主的实际损失进行关联"
      t.string :cross_contract_penalty_prohibited, comment: "禁止跨合同扣款"
      t.string :liability_clause_keywords, comment: "责任条款字眼:乙方应承担甲方的一切损失,乙方应承担甲方利润,乙方应承担甲方的工程,乙方应承担甲方的间接损失,乙方应承担甲方的维权费用,以上都不包含"

      t.timestamps
    end
  end
end
