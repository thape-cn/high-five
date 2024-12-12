class GoodEvent < ApplicationRecord
  has_many :user_good_events, dependent: :destroy
  has_many :users, through: :user_good_events

  validates :good_title, presence: true
end
