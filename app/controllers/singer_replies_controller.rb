class SingerRepliesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /replies
  def create
    @reply = SingerReply.new(reply_params)
    ActiveRecord::Base.transaction do
      if @reply.save
        @reply.comment.update_attribute(:status, 1)
        render json: @reply, status: :created, location: @reply
      else
        render json: @reply.errors.messages, status: :unprocessable_entity
      end
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def reply_params
    params.require(:singer_reply).permit(:singer_id, :text, :comment_id)
  end
end
