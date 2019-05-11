class Category < ApplicationRecord
  belongs_to :item
  has_many :logs

  def category_attributes=(attributes)
    category = Category.find_by(id: attributes[:id])
    self.category = category
  end
end
