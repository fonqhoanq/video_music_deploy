json.id @playlist.id
json.title @playlist.title
json.playlist_videos @playlist.playlist_by_topic_videos do |playlist_video|
  json.video do
    json.id playlist_video.video.id
    json.title playlist_video.video.title
    json.description playlist_video.video.description
    json.thumbnails url_for(playlist_video.video.thumbnails) if playlist_video.video.thumbnails.attached?
    json.views playlist_video.video.views
    json.singer do
      json.channelName playlist_video.video.singer.channel_name
    end  
  end
end
