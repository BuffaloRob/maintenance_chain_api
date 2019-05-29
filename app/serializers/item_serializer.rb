class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name
  # has_one :user
  belongs_to :user
  has_many :categories, through: :logs
  has_many :logs
end
