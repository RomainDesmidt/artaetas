class Courant < ApplicationRecord
  has_many :courant_annonces
  has_many :annonces, through: :courant_annonces
end
