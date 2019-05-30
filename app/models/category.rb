class Category < ApplicationRecord
  has_many :logs
  has_many :items, through: :logs

end
