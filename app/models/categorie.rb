class Categorie < ApplicationRecord
 has_many :categorie_annonces
 has_many :annonces, through: :categorie_annonces
end
