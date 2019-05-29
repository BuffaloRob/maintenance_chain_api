class Category < ApplicationRecord
  has_many :items, through: :logs
  has_many :logs

end
