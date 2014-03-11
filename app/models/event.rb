class Event < ActiveRecord::Base
	belongs_to :user
	belongs_to :register, class_name: "Event"
	has_and_belongs_to_many :registered_users, :class_name => 'User', :join_table => :events_users, :association_foreign_key => :user_id,:uniq =>true
   attr_accessible :title, :description, :venue, :published, :published_at, :event_start_date, :event_end_date, :user_id
end
