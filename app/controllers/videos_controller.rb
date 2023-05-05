class VideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_video, only: [:show, :update, :update_thumbnails, :destroy, :update_views]

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
                          .order("updated_at DESC")
  end

  def show_public_videos
    @public_videos = Video.where(video_status: :is_public)
                          .paginate(page: params[:page], per_page: 12)
                          .order("updated_at DESC")
  end
  
  def show_singer_public_videos
    @singer_videos = Video.where(video_status: :is_public, singer_id: params[:singer_id])
                          .paginate(page: params[:page], per_page: 12)
                          .order("updated_at DESC")
  end

  def show_trending_videos
    @trending_videos = Video.where(video_status: :is_public)
                            .order(views: :desc)
                            .paginate(page: params[:page], per_page: 12)
  end

  def show_watched_videos
    @watched_videos = Video.joins("INNER JOIN histories ON videos.id = histories.video_id")
                          .where("histories.user_id = #{params[:user_id]}")
                          .paginate(page: params[:page], per_page: 12)
                          .order("histories.updated_at DESC")
  end

  def update_thumbnails
    if @video.update(thumbnails_params)
      render json: {thumbnails: url_for(@video.thumbnails)}
    else
      render json: @video.errors, status: :unprocessable_entity
    end  
  end

  def update_views
    if @video.increment!(:views)
      render json: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def show_videos_by_category
    @videos = Video.joins("INNER JOIN categories ON categories.id = videos.category_id")
                   .where("categories.title = '#{params[:category]}'")
                   .where("videos.video_status = 1")
                   .paginate(page: params[:page], per_page: 12)
                   .order(updated_at: :desc)

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
end
