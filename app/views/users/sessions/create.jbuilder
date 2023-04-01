json.id current_user.id
json.username current_user.name
json.email current_user.email
json.age current_user.age
json.authentication_token current_user.authentication_token
json.avatarUrl url_for(current_user.avatar) if current_user.avatar.attached?
