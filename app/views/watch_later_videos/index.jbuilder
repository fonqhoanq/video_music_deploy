json.array! @watch_later_videos do |watch_later_video|
  json.id watch_later_video.id
  json.user do
    json.username watch_later_video.user.name
  end
  json.video do
    json.id watch_later_video.video.id
    json.title watch_later_video.video.title
    json.description watch_later_video.video.description
    json.thumbnails url_for(watch_later_video.video.thumbnails) if watch_later_video.video.thumbnails.attached?
    json.views watch_later_video.video.views
    json.singer do
      json.channelName watch_later_video.video.singer.channel_name
    end
  end
  json.createdAt watch_later_video.created_at
end
