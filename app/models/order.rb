class Order < ApplicationRecord
  belongs_to :user
  belongs_to :annonce
  monetize :amount_cents
end
