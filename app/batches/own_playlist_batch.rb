class OwnPlaylistBatch
  def execute
    users = User.all
    users.each do |user|
      OwnPlaylistService.new(user).create_daily_playlist
      OwnPlaylistService.new(user).create_mix_playlist
    end
  end
end
