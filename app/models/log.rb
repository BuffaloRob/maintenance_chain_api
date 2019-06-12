class Log < ApplicationRecord
  belongs_to :category

  default_scope { order(date_due: :desc) }

  def category_attributes=(attributes)
    category = Category.find_by(id: attributes[:id])
    self.category = category
  end

  # def self.past_due
  #   where("date_due <=?", Time.current)
  # end
  
  # def self.latest_past_due
  #   self.past_due.to_a.flatten
  #     .group_by(&:category_id)
  #     .collect{|key,arr| arr.first}
  # end

end
