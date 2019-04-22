class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name
  # has_one :user
  belongs_to :user
  has_many :logs
  has_many :categories
end
