class GoodEvent < ApplicationRecord
  has_many :user_good_events, dependent: :destroy
  has_many :users, through: :user_good_events, counter_cache: true
end
