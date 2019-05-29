class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  # has_one :logs
  has_many :items, through: :logs
  has_many :logs
end
