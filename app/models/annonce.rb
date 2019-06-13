class Annonce < ApplicationRecord
  belongs_to :user
  has_many :categorie_annonces
  has_many :categories, through: :categorie_annonces
  has_many :couleur_annonces
  has_many :couleurs, through: :couleur_annonces
  has_many :courant_annonces
  has_many :courants, through: :courant_annonces
  has_one  :order

end
