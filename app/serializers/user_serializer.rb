class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :google_id, :image_url
  
  has_many :items
end
