class LogSerializer < ActiveModel::Serializer
  attributes :id, :notes, :tools, :cost, :date_performed, :date_due, :category_id
  # has_one :items
  belongs_to :category
end
