class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :update, :destroy]
    skip_before_action :verify_authenticity_token
  
    # GET /comments
    def index
      @comments = Comment.all
    end
  
    # GET /comments/1
    def show
      render json: @comment
    end
  
    # POST /comments
    def create
      @comment = Comment.new(comment_params)
  
      if @comment.save
        @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /comments/1
    def update
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /comments/1
    def destroy
      @comment.destroy
    end
  
    def show_comments
      @comments = Comment.where(video_id: params[:video_id])
    end

    def show_comments_for_singer
      @comments = Comment.joins("INNER JOIN videos ON videos.id = comments.video_id")
                          .where("videos.singer_id = ? ", params[:singer_id])
                          .order(status: :asc, updated_at: :desc)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def comment_params
        params.require(:comment).permit(:user_id, :video_id, :text)
      end
  end
  