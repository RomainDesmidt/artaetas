class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :login, :current_password
  
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Z0-9 _\.]*\z/}
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :annonces
  has_many :courant_users
  has_many :courants, through: :courant_users
  has_many :orders

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users


  mount_uploader :photoprofil, PhotoUploader
  mount_uploader :photofond, PhotoUploader
  acts_as_voter
  acts_as_votable
  act_as_bookmarker
  after_create :warm_up_exercice
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.lastname = auth.info.name   # assuming the user model has a name
    end
  end
  
  def self.find_first_by_auth_conditions(warden_conditions) 
    conditions = warden_conditions.dup
    
    if login = conditions.delete(:login)
      where(conditions.to_hash).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
    else
      where(conditions.to_hash).first
    end
  end
  
  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
  
  def warm_up_exercice
    self.masquefavoris = true
    self.masquepublication = true
    self.save!
    send_welcome_email
  end
  
  
end
