class TrendingScore
  def execute
    videos = Video.all
    CalculateTrendingScoreService.new(videos).execute
  end
end
