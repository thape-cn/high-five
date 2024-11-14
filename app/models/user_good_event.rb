class UserGoodEvent < ApplicationRecord
  belongs_to :user
  belongs_to :good_event
end
