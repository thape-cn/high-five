class CreateGoodBadEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :good_events do |t|
      t.string :good_title

      t.timestamps
    end
    create_table :user_good_events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :good_event, null: false, foreign_key: true
      t.timestamps
    end
    create_table :bad_events do |t|
      t.string :bad_title

      t.timestamps
    end
    create_table :user_bad_events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bad_event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
