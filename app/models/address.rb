class Address < ActiveRecord::Base

   belongs_to :addressable, polymorphic: true
   attr_accessible :address, :zipcode, :website, :phone_no, :city, :state
end