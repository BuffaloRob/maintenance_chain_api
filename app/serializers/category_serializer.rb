class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :item_id

  has_many :logs
  belongs_to :item
end
