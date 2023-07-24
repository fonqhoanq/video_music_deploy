class OwnPlaylistsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_own_playlist, only: [:show, :update, :destroy]

    # GET /own_playlists
    def index
        @own_playlists = OwnPlaylist.where(user_id: params[:user_id], playlist_type: :individual_playlist).order("created_at DESC")
    end

    # GET /own_playlists/1
    def show
      @own_playlist
    end

    def check_video
      @own_playlists = OwnPlaylist.joins(:own_playlist_videos)
                                  .where(own_playlist_videos: {video_id: params[:video_id]})
                                  .where(user_id: params[:user_id])
    end

    def show_mix_playlist
      @mix_daily_playlists = OwnPlaylist.where(user_id: params[:user_id], playlist_status: :is_public)
                                        .where("playlist_type = 1 OR playlist_type = 2")
    end
    # POST /own_playlists
    def create
      ActiveRecord::Base.transaction do
        @own_playlist = OwnPlaylist.new(own_playlist_params)  
        if @own_playlist.save
            if params[:video_id].present?
                OwnPlaylistVideo.create(video_id: params[:video_id], own_playlist_id: @own_playlist.id)
            end
            render json: @own_playlist, status: :created, location: @own_playlist
        else
            render json: @own_playlist.errors, status: :unprocessable_entity
        end
      end
    end

    # PATCH/PUT /own_playlists/1
    def update
        if @own_playlist.update(own_playlist_params)
            render json: @own_playlist
        else
            render json: @own_playlist.errors, status: :unprocessable_entity
        end
    end

    # DELETE /own_playlists/1
    def destroy
        @own_playlist.destroy
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_own_playlist
            @own_playlist = OwnPlaylist.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def own_playlist_params
            params.require(:own_playlist).permit(:title, :user_id, :description, :playlist_status)
        end
end