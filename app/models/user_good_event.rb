class UserGoodEvent < ApplicationRecord
  belongs_to :user, counter_cache: :good_events_count
  belongs_to :good_event, counter_cache: :users_count
end
