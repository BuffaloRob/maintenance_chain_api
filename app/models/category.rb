class Category < ApplicationRecord
  belongs_to :logs
  has_many :items, through: :logs
end
