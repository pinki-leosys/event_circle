class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable

   has_one :address, as: :addressable
   #has_many :companies
   has_many :events
  has_and_belongs_to_many :registered_events, :class_name => 'Event', :join_table => :events_users, :association_foreign_key => :event_id,:uniq =>true
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :uname,:email, :password, :password_confirmation, :remember_me, :mobile_no
  # attr_accessible :title, :body

  validates :first_name, :presence => { :message => "Please enter first name" }
  validates :last_name, presence: true
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def is_registered?(event)
    registered_events.exists?(event)
  end
end
