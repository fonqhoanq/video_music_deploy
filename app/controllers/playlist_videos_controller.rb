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
    @user = User.find(params[:user_id])
    return unless @user.present?
    # user_playlists = UserPlaylist.where(user_id: @user.id).where.not(playlist_id: nil)
    user_playlists_count = UserPlaylist.where(user_id: @user.id).count
    PlaylistService.new(@user).create_playlist_for_user unless user_playlists_count > 1 # 1 is history playlist
    @playlists = Playlist.joins("INNER JOIN user_playlists ON user_playlists.playlist_id = playlists.id")
                         .where("user_playlists.user_id = #{params[:user_id]}")
  end

  private
  def set_playlist_video
    @playlist = Playlist.find(params[:id])
  end
end
