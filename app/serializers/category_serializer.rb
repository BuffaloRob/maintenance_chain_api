class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :logs
  belongs_to :item
end
