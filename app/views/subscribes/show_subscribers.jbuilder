json.array! @subscribers do |subscriber|
  json.id subscriber.user.id
  json.channelName subscriber.user.name
  json.avatarUrl url_for(subscriber.user.avatar) if subscriber.user.avatar.attached?
  json.createdAt subscriber.created_at
end
