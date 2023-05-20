json.id @own_playlist.id
json.title @own_playlist.title
json.description @own_playlist.description
json.own_playlist_videos @own_playlist.own_playlist_videos do |playlist_video|
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
json.updated_at @own_playlist.updated_at
json.status @own_playlist.playlist_status
