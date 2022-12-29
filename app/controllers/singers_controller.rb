class SingersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_singer, only: [:show, :update, :destroy]
  
    # GET /singers
    def index
      @singers = Singer.all
    end
  
    # GET /singers/1
    def show
      render json: @singer
    end
  
    # POST /singers
    def create
      @singer = Singer.new(singer_params)
  
      if @singer.save
        render json: @singer, status: :created, location: @singer
      else
        render json: @singer.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /singers/1
    def update
      if @singer.update(singer_params)
        render json: @singer
      else
        render json: @singer.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /singers/1
    def destroy
      @singer.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_singer
        @singer = Singer.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def singer_params
        params.require(:singer).permit(:email, :age, :name, :channel_name, :password, :password_confirmation)
      end
  end
  