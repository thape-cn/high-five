class AddUsersCountToBadEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :bad_events, :users_count, :integer, null: false, default: 0
    add_column :good_events, :users_count, :integer, null: false, default: 0
    add_column :users, :good_events_count, :integer, null: false, default: 0
    add_column :users, :bad_events_count, :integer, null: false, default: 0
  end
end
