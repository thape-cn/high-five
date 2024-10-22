class UserJobRole < ApplicationRecord
  belongs_to :user
  belongs_to :job_role
  belongs_to :manager_user, optional: true, class_name: :User
end
