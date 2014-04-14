class AddEventIdToCkeditor < ActiveRecord::Migration
  def change
  	add_column :ckeditor_assets, :event_id, :integer
  end
end
