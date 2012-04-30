class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
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
  # twitter fields
  field :twitter_handle,              :type => String
  field :twitter_profile_image_url,              :type => String
  field :twitter_data, :type => String

  validates_presence_of :name

  #validates_uniqueness_of :email, :case_sensitive => false
  #validates_uniqueness_of :twitter_handle, :case_sensitive => false

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :twitter_handle, :twitter_profile_image_url, :twitter_data


  has_many :templates, foreign_key: :creator_id
  has_many :publications, foreign_key: :creator_id

  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    users_criteria=self.where({:twitter_handle => data.nickname})
    if users_criteria.count>0
      users_criteria.first
    else
      self.create!(
          :password => Devise.friendly_token[0,20],
          :twitter_profile_image_url=>data.image,
          :twitter_handle => data.nickname,
          :name => data.name,
          :twitter_data => access_token.extra.raw_info
      )
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.twitter_data"] && session["devise.twitter_data"]["info"]
        user.twitter_handle = data["nickname"]
      end
    end
  end

end


