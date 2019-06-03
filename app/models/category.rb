class Category < ApplicationRecord
  has_many :logs, dependent: :destroy
  belongs_to :item
end
