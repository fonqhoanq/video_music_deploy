json.array! @subscribes_channels do |subscribes_channel|
    json.id subscribes_channel.singer.id
    json.channelName subscribes_channel.singer.channel_name
    json.avatarUrl url_for(subscribes_channel.singer.avatar) if subscribes_channel.singer.avatar.attached?
    json.title subscribes_channel.singer.name
end