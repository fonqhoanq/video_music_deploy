class WatchLaterVideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_watch_later_video, only: [:show, :update, :destroy]

  # GET /WatchLaterVideos
  def index
    if params[:page].present?
      @watch_later_videos = WatchLaterVideo.where(user_id: params[:user_id]).paginate(page: params[:page], per_page: 12).order("created_at DESC")
    else
      @watch_later_videos = WatchLaterVideo.where(user_id: params[:user_id]).order("created_at DESC")
    end
  end

  def show
    @watch_later_video
  end

  def create
    @watch_later_video = WatchLaterVideo.new(watch_later_video_params)
    
    if @watch_later_video.save
      render json: @watch_later_video
    else
      render json: @watch_later_video.errors, status: :unprocessable_entity
    end
  end

  def destroy 
    @watch_later_video.destroy
  end

  def check_watch_later
    @watch_later_video = WatchLaterVideo.where(user_id: params[:user_id], video_id: params[:video_id])
    if @watch_later_video.blank?
      render json: {status: 'Not found', message: 'Video is not in watch later list'}, status: :not_found
    else
      render json: @watch_later_video
    end
  end

  private

  def set_watch_later_video
    @watch_later_video = WatchLaterVideo.find(params[:id])
  end
  
  def watch_later_video_params
    params.require(:watch_later_video).permit(:video_id, :user_id)
  end
end
