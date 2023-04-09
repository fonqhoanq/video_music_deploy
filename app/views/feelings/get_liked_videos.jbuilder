json.array! @liked_feelings do |liked_feeling|
  json.id liked_feeling.video.id
  json.title liked_feeling.video.title
  json.description liked_feeling.video.description
  json.singer do
    json.id liked_feeling.video.singer.id
    json.channelName liked_feeling.video.singer.channel_name
  end
  json.createdAt liked_feeling.video.created_at
  json.public liked_feeling.video.public
  json.views liked_feeling.video.views
  json.url url_for(liked_feeling.video.url) if liked_feeling.video.url.attached?
  json.thumbnails url_for(liked_feeling.video.thumbnails) if liked_feeling.video.thumbnails.attached?
end
