class UserJobRole < ApplicationRecord
  belongs_to :user
  belongs_to :job_role
  belongs_to :manager_user, optional: true, class_name: :User
  has_many :managed_user_job_roles, class_name: "UserJobRole", foreign_key: "manager_user_id", primary_key: "user_id"
end
