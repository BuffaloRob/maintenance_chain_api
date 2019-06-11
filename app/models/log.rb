class Log < ApplicationRecord
  belongs_to :category

  default_scope { order(date_due: :desc) }

  # scope :current_log, ->{ where(active: true) }

  def category_attributes=(attributes)
    category = Category.find_by(id: attributes[:id])
    self.category = category
  end

  def self.past_due
    where("date_due <=?", Time.current).where(active: true)
    # where("date_due <=?", Time.current).order(date_due: :desc)
  end
  
end
