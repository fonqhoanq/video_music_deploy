class RepliesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /replies
  def create
    @reply = Reply.new(reply_params)

    if @reply.save
      render json: @reply, status: :created, location: @reply
    else
      render json: @reply.errors.messages, status: :unprocessable_entity
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def reply_params
    params.require(:reply).permit(:user_id, :singer_id, :text, :comment_id)
  end
end
