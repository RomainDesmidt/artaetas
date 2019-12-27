class Annonce < ApplicationRecord
  
 validates :photo, :name, :description,  presence: true
 validates :prix, format: {with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: {less_than_or_equal_to: 1000000}, presence: true
 validates :anneecreation, length: {maximum: 4}
  acts_as_votable
  belongs_to :user
  
  has_many :categorie_annonces, :dependent => :destroy
  has_many :cats, through: :categorie_annonces, source: :categorie
  
  has_many :couleur_annonces, :dependent => :destroy
  has_many :couleurs, through: :couleur_annonces
  
  has_many :courant_annonces, :dependent => :destroy
  has_many :courants, through: :courant_annonces
  
  has_one  :order

  mount_uploader :photo, PhotoUploader
  mount_uploader :photo_un, PhotoUploader
  mount_uploader :photo_deux, PhotoUploader

  acts_as_votable
  act_as_bookmarkee
  accepts_nested_attributes_for :categorie_annonces, :courant_annonces, :couleur_annonces
  # after_update :retour_confirmation
  
  # def retour_confirmation
  #  self.update_columns(envente_yesno: false)
  # end

  # def couleur_ids=(ids)
  # end

  # def courant_ids=(ids)
  # end
  
  # def categorie_ids=(ids)
  # end
  
 # def cat_ids=(ids)
 # end
 
 def sujetcontact
 end
 
 def corpscontact
 end
  
end
