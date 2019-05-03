class Item < ApplicationRecord
  belongs_to :user
  has_many :categories
  has_many :logs
end
