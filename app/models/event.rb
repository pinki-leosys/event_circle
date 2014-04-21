class Event < ActiveRecord::Base
	belongs_to :user
	belongs_to :register, class_name: "Event"
    has_one :address, as: :addressable
	has_and_belongs_to_many :registered_users, :class_name => 'User', :join_table => :events_users, :association_foreign_key => :user_id,:uniq =>true
    attr_accessible :title, :description, :venue, :published, :published_at, :event_start_date, :event_end_date, :user_id
  has_many :attachments, class_name: "Ckeditor::AttachmentFile"
  has_many :pictures, class_name: "Ckeditor::Picture"
  accepts_nested_attributes_for :pictures
    accepts_nested_attributes_for :address
      accepts_nested_attributes_for :attachments
  attr_accessible :address_attributes, :address, :pictures_attributes, :data,:event_starts, :event_ends,:attachments_attributes,:attachments

    after_save { |record| 
    	Ckeditor::AttachmentFile.update_all({:event_id => record.id}, {:event_id => nil, :assetable_id => record.user.id}) 
    	Ckeditor::Picture.update_all({:event_id => record.id}, {:event_id => nil, :assetable_id => record.user.id})
      record.pictures.update_all( {:assetable_id => record.user.id, :assetable_type => record.user.class.name},{:assetable_id => nil})
      record.attachments.update_all( {:assetable_id => record.user.id, :assetable_type => record.user.class.name},{:assetable_id => nil})
    }

  def self.search(search)  
    if search  
      where('published = ? AND title LIKE ?', true, "%#{search}%")  
    end  
  end

  def event_starts
    event_start_date.nil? ? event_start_date : event_start_date.strftime('%m/%d/%Y %I:%M %p')
  end
  def event_starts=(date)
    self.event_start_date=date
  end

  def event_ends
    event_end_date.nil? ? event_end_date : event_end_date.strftime('%m/%d/%Y %I:%M %p')
  end
  def event_ends=(date)
    self.event_end_date=date
  end
end
