class Log < ApplicationRecord
  belongs_to :category
  belongs_to :item, through: :category

  def category_attributes=(attributes)
    category = Category.find_by(id: attributes[:id])
    self.category = category
  end

  def self.past_due
    where("date_due <=?", Time.current)
  end
  
end
