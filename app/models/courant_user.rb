class CourantUser < ApplicationRecord
  belongs_to :courant
  belongs_to :user
end
