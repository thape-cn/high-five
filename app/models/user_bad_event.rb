class UserBadEvent < ApplicationRecord
  belongs_to :user
  belongs_to :bad_event
end
