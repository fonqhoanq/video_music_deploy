class SubscribesController < ApplicationController
    before_action :set_subscribe, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token
  
    # GET /subscribes
    def index
      @subscribes = Subscribe.all
    end
  
    # GET /subscribes/1
    def show
      render json: @subscribe
    end
  
    # POST /subscribes
    def create
      @subscribe = Subscribe.find_or_initialize_by(user_id: params[:user_id,], singer_id: params[:singer_id])
      if @subscribe.update(:status => params[:status])
        render json: @subscribe
      else
        render json: @subscribe.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /subscribes/1
    def update
      if @subscribe.update(subscribe_params)
        render json: @subscribe
      else
        render json: @subscribe.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /subscribes/1
    def destroy
      @subscribe.destroy
    end
  
    def check_subscribes
      @check_subscribes = Subscribe.find_by user_id: params[:user_id], singer_id: params[:singer_id]
      render json: @check_subscribes
    end
    
    def show_subscribes_channels
      @subscribes_channels = Subscribe.where(user_id: params[:user_id], status: :subscribe).order("updated_at DESC")
    end

    def show_subscribes_videos
      @subscribes_videos = Video.joins("INNER JOIN singers ON singers.id = videos.singer_id")
                                .joins("INNER JOIN subscribes ON subscribes.singer_id = singers.id")
                                .where("subscribes.user_id = #{params[:user_id]}")
                                .where("subscribes.status = 1")
                                .paginate(page: params[:page], per_page: params[:limit])
                                .order(updated_at: :desc)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_subscribe
        @subscribe = Subscribe.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def subscribe_params
        params.require(:subscribe).permit(:user_id, :singer_id, :status)
      end
  end
  