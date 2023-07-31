class VideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_video, only: [:show, :update, :update_thumbnails, :destroy, :update_views, :show_recommend_after_watching]

  def index
    @videos = Video.all
  end

  def show
    @video
  end

  def create
    @video = Video.new(video_params)
    @video.url.attach(params[:url])

    if @video.save
      render json: @video, except: :url, status: :created, location: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def update
    return unless params[:video][:hash_tags].present?
    ActiveRecord::Base.transaction do
      handle_send_notification(@video, params[:video][:title]) if @video.title.blank? && params[:video][:video_status] != 'scheduling'

      handle_send_scheduling_video_notification(@video, params[:video][:title], params[:video][:singer_id]) if @video.title.blank? && params[:video][:video_status] == 'scheduling'

      @video.update!(update_params)
      VideoHashTag.where(video_id: @video.id).destroy_all
      params[:video][:hash_tags].each do |hash_tag|
        VideoHashTag.create!(video_id: @video.id, hash_tag_id: hash_tag)
      end
      if params[:video][:video_status] == 'scheduling' 
        return unless params[:upload_video_at].present?
        schedule_at = Time.zone.parse(params[:upload_video_at])
        handle_schedule_upload_video(@video, schedule_at)
      end
    end
    render json: @video, except: :url
  end

  def destroy
    @video.destroy
  end

  def show_singer_videos
    @singer_videos = Video.where(singer_id: params[:singer_id])
                          .order("created_at DESC")
  end

  def show_public_videos
    @public_videos = Video.where(video_status: :is_public)
                          .paginate(page: params[:page], per_page: 12)
                          .order("RAND()")
  end
  
  def show_singer_public_videos
    @singer_videos = Video.where(video_status: :is_public, singer_id: params[:singer_id])
                          .paginate(page: params[:page], per_page: 12)
                          .order("created_at DESC")
  end

  def show_trending_videos
    videos = Video.all
    @trending_videos = Video.where(video_status: :is_public)
                            .order(trending_score: :desc)
                            .paginate(page: params[:page], per_page: 12)
  end

  def show_watched_videos
    @watched_videos = Video.joins("INNER JOIN histories ON videos.id = histories.video_id")
                          .where("histories.user_id = #{params[:user_id]}")
                          .paginate(page: params[:page], per_page: 12)
                          .order("histories.updated_at DESC")
  end

  def show_recommend_for_playlist
    @playlist_video_ids = Video.joins("INNER JOIN own_playlist_videos ON videos.id = own_playlist_videos.video_id")
                            .joins("INNER JOIN own_playlists ON own_playlists.id = own_playlist_videos.own_playlist_id")
                            .where("own_playlists.user_id = #{params[:user_id]}")
                            .where("own_playlists.id = #{params[:playlist_id]}")
                            .map(&:id)
    category_ids = Video.where(id: @playlist_video_ids).map(&:category_id).uniq
    videos = Video.where(category_id: category_ids, video_status: :is_public)
    @recommend_for_playlist_videos = videos.where.not(id: @playlist_video_ids)
                                          .order("RAND()")
                                          .limit(5)
  end

  def show_recommend_after_watching
    @recent_upload_video_ids = Video.joins("INNER JOIN histories ON videos.id = histories.video_id")
                                   .where("histories.user_id = #{params[:user_id]}")
                                   .where("videos.singer_id = #{params[:singer_id]}")
                                   .where("videos.video_status = 1")
                                   .order("videos.created_at DESC")
                                   .limit(10)
                                   .map(&:id)
    @top_views_video_ids = Video.where(singer_id: params[:singer_id], video_status: :is_public)
                                .order(views: :desc)
                                .limit(10)
                                .map(&:id)
    @watched_video_ids = Video.joins("INNER JOIN histories ON videos.id = histories.video_id")
                              .where("histories.user_id = #{params[:user_id]}")
                              .where("videos.video_status = 1")
                              .order("histories.created_at DESC")
                              .limit(10)
                              .map(&:id)
    @same_category_video_ids = Video.where(category_id: @video.category_id, video_status: :is_public)
                                    .limit(10)
                                    .map(&:id)
    video_ids = @recent_upload_video_ids.union(@top_views_video_ids).union(@watched_video_ids).union(@same_category_video_ids)

    @recommend_after_watching_videos = Video.where(id: video_ids)
                                            .where.not(id: @video.id)    
                                            .paginate(page: params[:page], per_page: 12)
  end

  def show_new_release_videos
    @new_release_videos = Video.where(video_status: :is_public)
                               .order(created_at: :desc)
                               .limit(10)
                               .order("RAND()")
  end

  def update_thumbnails
    if @video.update(thumbnails_params)
      render json: {thumbnails: url_for(@video.thumbnails)}
    else
      render json: @video.errors, status: :unprocessable_entity
    end  
  end

  def update_views
    duration = params[:duration].to_f
    current_time = params[:current_time].to_f
    user_id = params[:user_id]
    CalculateViewWorker.perform_async(@video.id,user_id, duration, current_time)
  end

  def show_videos_by_category
    @videos = Video.joins("INNER JOIN categories ON categories.id = videos.category_id")
                   .where("categories.title = '#{params[:category]}'")
                   .where("videos.video_status = 1")
                   .paginate(page: params[:page], per_page: 12)
                   .order(created_at: :desc)

  end

  def target_members_to_sent_notification
    singer = @video.singer
    target_members = User.joins("INNER JOIN subscribes ON subscribes.user_id = users.id")
                         .where("subscribes.singer_id = #{singer.id}")
                         .where("subscribes.status = 1")
  end

  def handle_send_notification(video, title)
    target_members_to_sent_notification.each do |member|
      MemberNotification.create!(video_id: video.id,
                                 content: "Recent upload video: #{title}",
                                 user_id: member.id,
                                 noti_status: :sent,
                                 noti_type: :recent_upload_video_notification
                                )
    end
  end

  def handle_send_scheduling_video_notification(video, title, singer_id)
    SingerNotification.create!(video_id: video.id,
                                content: "Scheduling video: #{title}",
                                singer_id: singer_id,
                                noti_status: :sent,
                                noti_type: :scheduling_video_notification
                              )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def video_params
      params.permit(:url, :singer_id, :category_id)
    end

    def update_params 
      params.require(:video).permit(:title, :description, :category_id, :video_status, :thumbnails)
    end

    def thumbnails_params
      params.permit(:thumbnails)
    end

    def handle_schedule_upload_video(video, schedule_at)
      reserve_service = VideoService.new(video)
      reserve_service.schedule(schedule_at)
      video.touch(:updated_at)
    end

    def should_execute_calculate_trending_score?(video)
      video.update_trending_at.nil? || video.update_trending_at < 1.day.ago
    end
end
