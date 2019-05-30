class Item < ApplicationRecord
  belongs_to :user
  has_many :logs
  has_many :categories, through: :logs
end
