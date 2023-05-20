class OwnPlaylistVideosController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_own_playlist_video, only: [:show, :update, :destroy]

    # GET /own_playlist_videos
    def index
        @own_playlist_videos = OwnPlaylistVideo.all

        render json: @own_playlist_videos
    end

    # GET /own_playlist_videos/1
    def show
        render json: @own_playlist_video
    end

    # POST /own_playlist_videos
    def create
        if params[:playlists].blank?
          @own_playlist_video = OwnPlaylistVideo.where(own_playlist_id: params[:playlist_id], video_id: params[:video_id]).first
          if @own_playlist_video.blank?
            @own_playlist_video = OwnPlaylistVideo.create!(own_playlist_id: params[:playlist_id], video_id: params[:video_id])
          end
        else
          params[:playlists].each do |playlist_id|
            @own_playlist_video = OwnPlaylistVideo.where(own_playlist_id: playlist_id, video_id: params[:own_playlist_video][:video_id]).first
            if @own_playlist_video.blank?
              @own_playlist_video = OwnPlaylistVideo.create!(own_playlist_id: playlist_id, video_id: params[:own_playlist_video][:video_id])
            end
          end
        end

        if @own_playlist_video.present?
          @own_playlist_video.own_playlist.update!(updated_at: Time.zone.now)
          @own_playlist_video
        else
          render json: @own_playlist_video.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /own_playlist_videos/1
    def update
        if @own_playlist_video.update(own_playlist_video_params)
            render json: @own_playlist_video
        else
            render json: @own_playlist_video.errors, status: :unprocessable_entity
        end
    end

    # DELETE /own_playlist_videos/1
    def remove_video
        # playlist_id = params[:playlists].split(",").map(&:to_i)
        if params[:playlists].present?
          @own_playlist_videos = OwnPlaylistVideo.where("video_id = ? AND own_playlist_id NOT IN (?)", params[:own_playlist_video][:video_id], params[:playlists])
          @own_playlist_videos.destroy_all
        else
          @own_playlist_video = OwnPlaylistVideo.where(own_playlist_id: params[:own_playlist_id], video_id: params[:video_id]).first
          @own_playlist_video.destroy if @own_playlist_video.present?
        end
        if @own_playlist_video.present?
          @own_playlist_video.own_playlist.update!(updated_at: Time.zone.now)
        end
        render json: @own_playlist_video
    end

    def destroy
        @own_playlist_video.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_own_playlist_video
        @own_playlist_video = OwnPlaylistVideo.find(params[:id])
    end  

    # Only allow a trusted parameter "white list" through.
    def own_playlist_video_params
        params.require(:own_playlist_video).permit(:own_playlist_id, :video_id)
    end
end