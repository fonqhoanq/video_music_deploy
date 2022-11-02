class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :age, :name
end
