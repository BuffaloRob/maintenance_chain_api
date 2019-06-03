class Item < ApplicationRecord
  belongs_to :user
  has_many :categories, dependent: :destroy
  has_many :logs, through: :categories, dependent: :destroy
end
