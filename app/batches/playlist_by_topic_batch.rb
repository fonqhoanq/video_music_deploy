class PlaylistByTopicBatch
  def execute_singer_topic
    PlaylistByTopicService.new.create_playlist_by_singer_topic
  end

  def execute_trending_topic
    PlaylistByTopicService.new.create_or_update_playlist_by_trending_topic
  end
end
