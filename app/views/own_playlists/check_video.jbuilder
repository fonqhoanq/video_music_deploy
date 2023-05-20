json.array! @own_playlists do |own_playlist|
  json.id own_playlist.id
  json.title own_playlist.title
  json.description own_playlist.description
  json.status own_playlist.playlist_status
end
  