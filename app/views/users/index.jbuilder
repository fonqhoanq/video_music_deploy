json.array! @users do |user|
    json.id user.id
    json.name user.name
    json.email user.email
    json.age user.age
    json.created_at user.created_at
  end