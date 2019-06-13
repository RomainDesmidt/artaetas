class Couleur < ApplicationRecord
  has_many :couleur_annonces
  has_many :annonces, through: :couleur_annonces
end
