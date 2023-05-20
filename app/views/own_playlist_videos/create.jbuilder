json.video do
  json.id @own_playlist_video.video.id
  json.title @own_playlist_video.video.title
  json.description @own_playlist_video.video.description
  json.thumbnails url_for(@own_playlist_video.video.thumbnails) if @own_playlist_video.video.thumbnails.attached?
  json.views @own_playlist_video.video.views
  json.singer do
    json.channelName @own_playlist_video.video.singer.channel_name
  end  
end
