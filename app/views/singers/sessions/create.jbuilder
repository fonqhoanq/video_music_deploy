json.id current_singer.id
json.channelName current_singer.channel_name
json.email current_singer.email
json.age current_singer.age
json.authentication_token current_singer.authentication_token
json.avatarUrl url_for(current_singer.avatar) if current_singer.avatar.attached?
