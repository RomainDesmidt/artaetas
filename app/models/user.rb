class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
end
