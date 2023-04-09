class HistoriesController < ApplicationController
    before_action :set_history, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token
  
    # GET /histories
    def index
      @histories = History.where(user_id: params[:user_id], history_type: params[:history_type]).paginate(page: params[:page], per_page: 12).order("created_at DESC").distinct
    end
  
    # GET /histories/1
    def show
      render json: @history
    end
  
    # POST /histories
    def create
      @history = History.new(history_params)

      # Handle create history playlist
      user = User.find_by(id: params[:user_id])
      playlist = Playlist.find_by(title: "History playlist for #{user.name}")
      if playlist.blank?
        PlaylistService.new(user).create_history_playlist
      end

      if @history.save
        render json: @history, status: :created, location: @history
      else
        render json: @history.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /histories/1
    def update
      if @history.update(history_params)
        render json: @history
      else
        render json: @history.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /histories/1
    def destroy
      @history.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_history
        @history = History.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def history_params
        params.require(:history).permit(:user_id, :video_id, :search_text, :history_type)
      end
  end
  