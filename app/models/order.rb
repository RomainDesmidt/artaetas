class Order < ApplicationRecord
  before_create :set_slug
  after_create :execute_later
  belongs_to :user
  belongs_to :annonce
  monetize :amount_cents
  
  
  def set_slug
    loop do
     self.slug = SecureRandom.uuid
     break unless Order.where(slug: slug).exists?
    end
  end
  
  def execute_later
    #puts "l'id de cette order est : #{self.id}"
    CallingOrderJob.perform_in(10, self.id)
  end
end
