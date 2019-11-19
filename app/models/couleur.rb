class Couleur < ApplicationRecord
  has_many :couleur_annonces
  has_many :annonces, through: :couleur_annonces
  
  after_create :couleur_dominante_to_name
  
  
  def couleur_dominante_to_name
    self.name = self.couleur_dominante
    self.save!
  end
end
