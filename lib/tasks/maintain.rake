namespace :maintain do
  desc "Reset counters"
  task reset_counters: :environment do
    BadEvent.find_each do |bad_event|
      BadEvent.reset_counters(bad_event.id, :users) if bad_event.users.present?
    end
    GoodEvent.find_each do |good_event|
      GoodEvent.reset_counters(good_event.id, :users) if good_event.users.present?
    end
    User.find_each do |user|
      User.reset_counters(user.id, :bad_events) if user.bad_events.present?
      User.reset_counters(user.id, :good_events) if user.good_events.present?
    end
  end
end
