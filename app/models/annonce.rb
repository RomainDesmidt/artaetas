class Annonce < ApplicationRecord

 # after_update :enventeorno
 before_create :set_slug
 after_update :no_photo_envente_no

 validates :name, :description,  presence: true
 validates :prix, format: {with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: {less_than_or_equal_to: 1000000}, presence: true
 validates :anneecreation, inclusion: { in: -1000..2100 }
  acts_as_votable
  belongs_to :user
  
  has_many :categorie_annonces, :dependent => :destroy
  has_many :cats, through: :categorie_annonces, source: :categorie
  
  has_many :couleur_annonces, :dependent => :destroy
  has_many :couleurs, through: :couleur_annonces
  
  has_many :courant_annonces, :dependent => :destroy
  has_many :courants, through: :courant_annonces
  
  include PgSearch
  pg_search_scope :search_annonce,
    against: [ :name, :description, :nom_artiste ],
    associated_against: {
      courants: [ :name ],
      cats: [ :name ],
      couleurs: [ :name ],
      user: [ :username ]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

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
 
  mount_uploader :photo, PhotoUploader
  mount_uploader :photo_un, PhotoUploader
  mount_uploader :photo_deux, PhotoUploader 
 
 
  attr_accessor :faire_un_don
 # def enventeorno
 #  unless self.envente_yesno == nil
 #   self.update(envente_yesno: nil)
 #   # AnnonceMailer.with(user: self.user, annonce: self).confirm_edit_annonce.deliver_now
 #  end
 # end

    
 def no_photo_envente_no
  if self.photo.blank? 
   unless self.envente_yesno == nil
    self.update(envente_yesno: nil)
   end
  end
 end
 
 def sujetcontact
 end
 
 def corpscontact
 end
 
 def set_slug
  loop do
   self.slug = SecureRandom.uuid
   break unless Annonce.where(slug: slug).exists?
  end
 end
 
 def photolow
  if self.photo?
   httpsimagepath = self.photo.url.insert(4, 's')
   httpsimagepath.slice! self.photo.filename
   httpsimagepath = httpsimagepath + 'q_auto:low/' + self.photo.filename
   return httpsimagepath
  end
 end
 
  def photoexif
   if self.photo?
    httpsimagepath = self.photo.url.insert(4, 's')
    httpsimagepath.slice! self.photo.filename
    httpsimagepath = httpsimagepath + 'a_exif/' + self.photo.filename
    return httpsimagepath
   end
  end
 
  # def exif
  #  puts self.url 
  #  # httpsimagepath = self.url.insert(4, 's')
  #  # httpsimagepath.slice! self.filename
  #  # httpsimagepath = httpsimagepath + 'a_exif/' + self.filename
  #  # return httpsimagepath
  # end
  
end
