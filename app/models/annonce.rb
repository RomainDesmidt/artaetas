class Annonce < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :categorie_annonces
  has_many :categories, through: :categorie_annonces
  has_many :couleur_annonces
  has_many :couleurs, through: :couleur_annonces
  has_many :courant_annonces
  has_many :courants, through: :courant_annonces
  has_one  :order

  mount_uploader :photo, PhotoUploader
  mount_uploader :photo_un, PhotoUploader
  mount_uploader :photo_deux, PhotoUploader

  acts_as_votable
  act_as_bookmarkee


  def couleur_ids=(ids)
  end

  # def courant_ids=(ids)
  # end
  
  # def categorie_ids=(ids)
  # end
  
  def cat_ids=(ids)
  end
  
end
