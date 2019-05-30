class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :logs
  has_many :items, through: :logs
end
