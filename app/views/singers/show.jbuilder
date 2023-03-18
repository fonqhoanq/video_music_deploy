json.id @singer.id
json.channelName @singer.channel_name
json.avatarUrl url_for(@singer.avatar) if @singer.avatar.attached?
json.subscribers @singer.subscribes.count