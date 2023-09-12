class UserSerializer < ActiveModel::Serializer
  attributes :id, :auth0_user
  
  has_many :items
end
