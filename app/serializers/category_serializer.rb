class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  # has_one :logs
  belongs_to :logs
  has_many :items, through: :logs
end
