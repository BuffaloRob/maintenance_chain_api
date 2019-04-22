class Category < ApplicationRecord
  belongs_to :items
  has_many :logs
end
