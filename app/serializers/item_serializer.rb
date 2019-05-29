class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name
  # has_one :user
  belongs_to :user
  has_many :categories
  has_many :logs, through: :categories
end
