class Varlocale < ApplicationRecord
    validates :valeurchamp, :inclusion => 1..100
end
