class Item < ApplicationRecord
  belongs_to :user
  has_many :categories, through: :logs
  has_many :logs
end
