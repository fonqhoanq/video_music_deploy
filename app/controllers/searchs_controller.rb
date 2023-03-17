class SearchsController < ApplicationController
    skip_before_action :verify_authenticity_token
 
    # GET /searchs
    def index
      @search_singer_results = Singer.ransack(channel_name_cont: params[:text])
      @singers = @search_singer_results.result.paginate(page: params[:page], per_page: 5).order("created_at DESC")

      @search_video_results = Video.ransack(title_cont: params[:text])
      @videos = @search_video_results.result.paginate(page: params[:page], per_page: 5).order("created_at DESC")
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_search
        @search = search.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def search_params
        params.require(:search).permit(:page, :text)
      end
  end
  