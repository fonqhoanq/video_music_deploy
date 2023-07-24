class PlaylistByTopicService
  def create_playlist_by_singer_topic
    singers = Singer.all
    return if singers.blank?
    singers.each do |singer|
      playlist_by_topic = PlaylistByTopic.where(title: "This is #{singer.name}")
      return if playlist_by_topic.present?
      playlist_by_topic = PlaylistByTopic.create!(title: "This is #{singer.name}", playlist_type: :singer_topic)
      return if playlist_by_topic.blank?
      videos = Video.where(singer_id: singer.id)
                    .where(video_status: :is_public)
                    .order("RAND()")
                    .limit(20)
      videos.each do |video|
        ActiveRecord::Base.transaction do
          PlaylistByTopicVideo.create!(playlist_by_topic_id: playlist_by_topic.id, video_id: video.id)
          playlist_by_topic.increment!(:video_numbers)
        end
        
      end
    end
  end

  def create_or_update_playlist_by_trending_topic
    playlist_by_topic = PlaylistByTopic.find_by(playlist_type: :trending_topic)
    playlist_by_topic.destroy if playlist_by_topic.present?
    playlist_by_topic = PlaylistByTopic.create!(title: "This is trending playlist", playlist_type: :trending_topic)
    return if playlist_by_topic.blank?
    trending_videos =  Video.where(video_status: :is_public)
                            .order(trending_score: :desc)
                            .limit(20)
    trending_videos.each do |video|
      ActiveRecord::Base.transaction do
        PlaylistByTopicVideo.create!(playlist_by_topic_id: playlist_by_topic.id, video_id: video.id)
        playlist_by_topic.increment!(:video_numbers)
      end
    end
  end
end
