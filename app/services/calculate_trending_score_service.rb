class CalculateTrendingScoreService 
  def initialize(videos)
    @videos = videos
  end

  def execute
    max_views = @videos.maximum(:views)
    max_day = Video.maximum(:created_at).to_date
    min_day = Video.minimum(:created_at).to_date
    max_like = 0.0
    @videos.each do |video|
      like_scale =  video.dislikes == 0 ? video.likes.to_f : video.likes.to_f / video.dislikes.to_f
      max_like = like_scale if like_scale > max_like
    end
    days = (max_day - min_day).to_i
    video_ids = @videos.pluck(:id)
    @videos.each do |video|
     like_scale = video.dislikes == 0 ? video.likes.to_f : video.likes.to_f / video.dislikes.to_f
     like_score = like_scale.to_f / max_like.to_f
     view_score = video.views.to_f / max_views
     day_score = (video.created_at.to_date - min_day).to_f / days
     video.update!(trending_score: like_score + view_score + day_score, update_trending_at: Time.now)
    end
  end
end
