class Annonce < ApplicationRecord
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

  def categorie_ids=(ids)
  #   ids.each do |id|
  #     categorie = Categorie.find(id)
  #     categoriea = CategorieAnnonce.new( categorie: categorie, annonce_id: self.id )
  #     categoriea.save!
  #   end
  end

  def couleur_ids=(ids)
  end

  def courant_ids=(ids)
  end
end
