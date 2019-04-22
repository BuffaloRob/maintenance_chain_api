class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  # has_one :logs
  belongs_to :items
  has_many :logs
end
