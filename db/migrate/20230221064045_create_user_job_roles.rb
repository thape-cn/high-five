class CreateUserJobRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_job_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job_role, null: false, foreign_key: true
      t.references :manager_user, null: true
      t.string :company
      t.string :department
      t.string :dept_code
      t.string :title
      t.string :job_user_id, null: true
      t.boolean :is_active, null: false, default: false

      t.timestamps
    end
  end
end
