class Category < ApplicationRecord
  belongs_to :item
  has_many :logs
end
