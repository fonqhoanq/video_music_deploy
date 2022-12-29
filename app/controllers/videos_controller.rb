class VideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_video, only: [:show, :update, :update_thumbnails, :destroy]

  def index
    @videos = Video.all
  end

  def show
    render json: @video
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
    if @video.update(update_params)
        render json: @video, except: :url
      else
        render json: @video.errors, status: :unprocessable_entity
      end  
    end

  def destroy
    @video.destroy
  end

  def show_public_videos
    @videos = Video.where(public: true).paginate(page: params[:page], per_page: 12).order("created_at DESC")
  end

  def update_thumbnails
    if @video.update(thumbnails_params)
      render json: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def video_params
      params.permit(:url, :singer_id)
    end

    def update_params 
      params.require(:video).permit(:title, :description, :category_id, :public, :thumbnails)
    end

    def thumbnails_params
      params.permit(:thumbnails)
    end
end
