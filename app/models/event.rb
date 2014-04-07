class Event < ActiveRecord::Base
	belongs_to :user
	belongs_to :register, class_name: "Event"
    has_one :address, as: :addressable
	has_and_belongs_to_many :registered_users, :class_name => 'User', :join_table => :events_users, :association_foreign_key => :user_id,:uniq =>true
    attr_accessible :title, :description, :venue, :published, :published_at, :event_start_date, :event_end_date, :user_id
    accepts_nested_attributes_for :address
  attr_accessible :address_attributes, :address
  has_many :attachment_files, class_name: "Ckeditor::AttachmentFile"
  has_many :pictures, class_name: "Ckeditor::Picture"

    after_save { |record| 
    	Ckeditor::AttachmentFile.update_all({:event_id => record.id}, {:event_id => nil, :assetable_id => record.user.id}) 
    	Ckeditor::Picture.update_all({:event_id => record.id}, {:event_id => nil, :assetable_id => record.user.id})
    }

end
