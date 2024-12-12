class BadEvent < ApplicationRecord
  has_many :user_bad_events, dependent: :destroy
  has_many :users, through: :user_bad_events

  validates :bad_title, presence: true
end
