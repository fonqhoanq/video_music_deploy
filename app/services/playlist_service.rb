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

  def create_playlist_by_hashtag(hash_tag_title)
    videos = Video.joins("INNER JOIN video_hash_tags ON video_hash_tags.video_id = videos.id")
                  .joins("INNER JOIN hash_tags ON hash_tags.id = video_hash_tags.hash_tag_id")
                  .where("hash_tags.title = '#{hash_tag_title}'")
    ActiveRecord::Base.transaction do
      hash_tag = HashTag.find_by(title: hash_tag_title)
      return unless hash_tag.present?
      playlist = Playlist.find_by(hash_tag_id: hash_tag.id)
      return unless playlist.present?
      UserPlaylist.create!(user_id: @user.id, playlist_id: playlist.id)
      videos.each do |video|
        PlaylistVideo.create!(playlist_id: playlist.id,
                              video_id: video.id)
      end
    end
  end

  def create_playlist_for_user
    hash_tags = HashTag.where.not(title: 'history')
    hash_tags.each do |hash_tag|
      create_playlist_by_hashtag(hash_tag.title)
    end
  end
end
