class Order < ApplicationRecord
  before_create :set_slug
  belongs_to :user
  belongs_to :annonce
  monetize :amount_cents
  
  
  def set_slug
    loop do
     self.slug = SecureRandom.uuid
     break unless Order.where(slug: slug).exists?
    end
  end
end
