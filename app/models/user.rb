class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Sociable::Profile::Facebook::Mongoid
  include Sociable::Profile::Twitter::Mongoid
  include Sociable::Profile::Authorization


 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  field :name
  field :email,              :type => String #, :null => false
  field :encrypted_password, :type => String, :null => false
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time
  field :remember_created_at, :type => Time
  field :sign_in_count,      :type => Integer
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  validates_presence_of :name

  #validates_uniqueness_of :email, :case_sensitive => false
  #validates_uniqueness_of :twitter_handle, :case_sensitive => false

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :templates, foreign_key: :creator_id
  has_many :publications, foreign_key: :creator_id


end


