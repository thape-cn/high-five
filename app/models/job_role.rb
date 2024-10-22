class JobRole < ApplicationRecord
  has_many :user_job_roles, dependent: :destroy
  has_many :users, through: :user_job_roles
end
