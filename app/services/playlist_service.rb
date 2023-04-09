class PlaylistService
  def initialize(user)
    @user = user
  end

  def create_history_playlist
    # Show history video
    videos = Video.joins("INNER JOIN histories ON histories.video_id = videos.id")
                  .joins("INNER JOIN users ON users.id = histories.user_id ")
                  .where("histories.history_type = 0")
                  .where("histories.user_id = #{@user.id}")

    ActiveRecord::Base.transaction do
      hash_tag = HashTag.find_by(title: 'history')
      playlist = Playlist.create!(title: "History playlist for #{@user.name}",
                                  description: "Recent videos playlist for #{@user.name}",
                                  hash_tag_id: hash_tag.id)
      UserPlaylist.create!(user_id: @user.id, playlist_id: playlist.id)
      videos.each do |video|
        PlaylistVideo.create!(playlist_id: playlist.id,
                              video_id: video.id)
      end
    end
  end
end