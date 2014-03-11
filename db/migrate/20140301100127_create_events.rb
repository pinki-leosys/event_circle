class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title,              :null => false, :default => ""
      t.string :description,              :null => false, :default => ""
      t.string :venue,              :null => false, :default => ""
      t.boolean :published, :default => false
      t.datetime :event_start_date
      t.datetime :event_end_date
      t.integer :user_id
      t.datetime :published_at

      t.timestamps
    end
  end
end