class UserBadEvent < ApplicationRecord
  belongs_to :user, counter_cache: :bad_events_count
  belongs_to :bad_event, counter_cache: :users_count
end
