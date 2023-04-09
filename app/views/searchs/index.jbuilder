singer_json = json.array! @singers do |singer|
  json.id singer.id
  json.channelName singer.channel_name
  json.avatarUrl url_for(singer.avatar) if singer.avatar.attached?
  json.subscribers singer.subscribes.subscribe.count
  json.description singer.description
  json.videos singer.videos.count
end

videos_json = json.array! @videos do |video|
  json.id video.id
  json.title video.title
  json.description video.description
  json.singer do
      json.id video.singer.id
      json.channelName video.singer.channel_name
  end
  json.createdAt video.created_at
  json.public video.public
  json.views video.views
  json.url url_for(video.url) if video.url.attached?
  json.thumbnails url_for(video.thumbnails) if video.thumbnails.attached?
end

singer_json + videos_json 
