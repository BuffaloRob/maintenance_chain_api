class Log < ApplicationRecord
  belongs_to :item
  belongs_to :category

  def category_attributes=(attributes)
    category = Category.find_by(id: attributes[:id])
    self.category = category
  end
end
