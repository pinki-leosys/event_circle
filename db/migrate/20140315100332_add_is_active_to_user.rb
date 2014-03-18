class AddIsActiveToUser < ActiveRecord::Migration
  def self.up
  	add_column :users, :is_active, :boolean, :null => false, :default => "0"
  end

  def self.down
  	remove_column :users, :is_active
  end
end