class OwnPlaylistService
  def initialize(user)
    @user = user
  end

  def create_mix_playlist
    # write query get catogory of video that user watch most
    category = History.select("count(*) as views, categories.id as category_id, categories.title as category_title")
                      .joins("INNER JOIN videos ON histories.video_id = videos.id")
                      .joins("INNER JOIN categories ON videos.category_id = categories.id")
                      .where("histories.user_id = ?", @user.id)
                      .group("categories.id")
                      .order("views DESC")
                      .limit(3)
    category.each do |categori|
      video_ids = Video.where(category_id: categori.category_id, video_status: :is_public).map(&:id)
      @total_video_ids = video_ids if @total_video_ids.blank?
      @total_video_ids = @total_video_ids.union(video_ids)
    end
    videos = Video.where(id: @total_video_ids).order("RAND()").limit(30)
    
    return if videos.length < 10
    videos_1 = videos[0..9]

    mix_playlist1 = OwnPlaylist.where(user_id: @user.id, playlist_type: :mix_playlist, playlist_status: :is_public, title: "Mix playlist 1").first
    if mix_playlist1.blank?
      mix_playlist1 = OwnPlaylist.create!(user_id: @user.id, playlist_type: :mix_playlist, playlist_status: :is_public, title: "Mix playlist 1")
    end
    old_videos = OwnPlaylistVideo.where(own_playlist_id: mix_playlist1.id)
    old_videos.destroy_all if old_videos.present?
    videos_1.each do |video|
      OwnPlaylistVideo.create!(own_playlist_id: mix_playlist1.id, video_id: video.id)
    end

    return if videos.length < 20
    videos_2 = videos[10..19]  


    mix_playlist2 = OwnPlaylist.where(user_id: @user.id, playlist_type: :mix_playlist, playlist_status: :is_public, title: "Mix playlist 2").first
    if mix_playlist2.blank?
      mix_playlist2 = OwnPlaylist.create!(user_id: @user.id, playlist_type: :mix_playlist, playlist_status: :is_public, title: "Mix playlist 2")
    end
    old_videos = OwnPlaylistVideo.where(own_playlist_id: mix_playlist2.id)
    old_videos.destroy_all if old_videos.present?
    videos_2.each do |video|
      OwnPlaylistVideo.create!(own_playlist_id: mix_playlist2.id, video_id: video.id)
    end
        
    return if videos.length < 30
    videos_3 = videos[20..29]


    mix_playlist3 = OwnPlaylist.where(user_id: @user.id, playlist_type: :mix_playlist, playlist_status: :is_public, title: "Mix playlist 3").first
    if mix_playlist3.blank?
      mix_playlist3 = OwnPlaylist.create!(user_id: @user.id, playlist_type: :mix_playlist, playlist_status: :is_public, title: "Mix playlist 3")
    end
    old_videos = OwnPlaylistVideo.where(own_playlist_id: mix_playlist3.id)
    old_videos.destroy_all if old_videos.present?
    videos_3.each do |video|
      OwnPlaylistVideo.create!(own_playlist_id: mix_playlist3.id, video_id: video.id)
    end
    # loop videos from video 1 to video 10 and create playlist
  end

  def create_daily_playlist
    most_watch_video_ids = History.select("count(*) as views, videos.id as video_id, videos.title as video_title")
                              .joins("INNER JOIN videos ON histories.video_id = videos.id")
                              .where("histories.user_id = ?", @user.id)
                              .group("videos.id")
                              .order("views DESC")
                              .limit(15)
                              .map(&:video_id)
    recent_upload_video_ids = Video.where(video_status: :is_public)
                                   .order("created_at DESC")
                                   .limit(15)
                                   .map(&:id)
    trending_video_ids = Video.where(video_status: :is_public)
                              .order(trending_score: :desc)
                              .limit(15)
                              .map(&:id)
    video_ids = most_watch_video_ids.union(recent_upload_video_ids).union(trending_video_ids)

    videos = Video.where(id: video_ids).order("RAND()").limit(30)
    return if videos.length < 15
    videos_1 = videos[0..14]

    daily_playlist1 = OwnPlaylist.where(user_id: @user.id, playlist_type: :daily_playlist, playlist_status: :is_public, title: "Daily playlist 1").first
    if daily_playlist1.blank?
      daily_playlist1 = OwnPlaylist.create!(user_id: @user.id, playlist_type: :daily_playlist, playlist_status: :is_public, title: "Daily playlist 1")
    end
    old_videos = OwnPlaylistVideo.where(own_playlist_id: daily_playlist1.id)
    old_videos.destroy_all if old_videos.present?
    videos_1.each do |video|
      OwnPlaylistVideo.create!(own_playlist_id: daily_playlist1.id, video_id: video.id)
    end

    return if videos.length < 30
    videos_2 = videos[15..29]

    daily_playlist2 = OwnPlaylist.where(user_id: @user.id, playlist_type: :daily_playlist, playlist_status: :is_public, title: "Daily playlist 2").first
    if daily_playlist2.blank?
      daily_playlist2 = OwnPlaylist.create!(user_id: @user.id, playlist_type: :daily_playlist, playlist_status: :is_public, title: "Daily playlist 2")
    end
    old_videos = OwnPlaylistVideo.where(own_playlist_id: daily_playlist2.id)
    old_videos.destroy_all if old_videos.present?
    videos_2.each do |video|
      OwnPlaylistVideo.create!(own_playlist_id: daily_playlist2.id, video_id: video.id)
    end
  end
end
