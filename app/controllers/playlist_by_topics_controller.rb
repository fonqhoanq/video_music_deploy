class PlaylistByTopicsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_playlist_video, only: [:update, :show]
  def index
    @playlist_by_topics = PlaylistByTopic.all
  end

  def show
    @playlist
  end

  def show_singer_topic_playlist
    @playlists = PlaylistByTopic.where(playlist_type: :singer_topic).where.not(video_numbers: 0)
  end

  private
  def set_playlist_video
    @playlist = PlaylistByTopic.find(params[:id])
  end
end
