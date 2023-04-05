class MemberNotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_notification, only: [:update]
  def index
    @member_notifications = MemberNotification.all
  end

  def show_recent_videos_notifications
    @member_notifications = MemberNotification.where(user_id: params[:user_id], noti_status: :sent, noti_type: params[:noti_type]).order(read_at: :asc)
  end

  def update
    if @member_notification.update!(read_at: Time.current)
      render json: @member_notification
    else
      render json: @member_notification.errors.messages, status: :unprocessable_entity
    end
  end

  private
  def set_notification
    @member_notification = MemberNotification.find(params[:id])
  end
end
