class PlaylistBatch
  def exec_playlist
    user = User.first
    PlaylistService.new(user).update_playlist_for_user
  end
end
