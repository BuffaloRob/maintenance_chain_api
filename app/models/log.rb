class Log < ApplicationRecord
  belongs_to :items
  has_many :categories
end
