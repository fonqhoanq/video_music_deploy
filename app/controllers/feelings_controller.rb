class FeelingsController < ApplicationController
    before_action :set_feeling, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token
  
    # GET /feelings
    def index
      @feelings =Feeling.all
    end
  
    # GET /feelings/1
    def show
      render json: @feeling
    end
  
    # POST /feelings
    def create
      @feeling = Feeling.find_or_initialize_by(user_id: params[:user_id,], video_id: params[:video_id])
      if @feeling.update(:status => params[:status])
        render json: @feeling
      else
        render json: @feeling.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /feelings/1
    def update
      if @feeling.update(feeling_params)
        render json: @feeling
      else
        render json: @feeling.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /feelings/1
    def destroy
      @feeling.destroy
    end
  
    def check_feelings
      @check_feelings = Feeling.find_by user_id: params[:user_id], video_id: params[:video_id]
      render json: @check_feelings
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_feeling
        @feeling = Feeling.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def feeling_params
        params.require(:feeling).permit(:user_id, :video_id, :status)
      end
  end
  