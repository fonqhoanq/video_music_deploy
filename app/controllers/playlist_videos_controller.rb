class PlaylistVideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_playlist_video, only: [:update, :show]
  def index
    @playlist_videos = PlaylistVideo.all
  end

  def show
    @playlist
  end

  def show_playlist_for_user
    @playlists = Playlist.joins("INNER JOIN user_playlists ON user_playlists.playlist_id = playlists.id")
                         .where("user_playlists.user_id = #{params[:user_id]}")
  end

  private
  def set_playlist_video
    @playlist = Playlist.find(params[:id])
  end
end
