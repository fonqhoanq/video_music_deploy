class SingerNotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_notification, only: [:update]
  def index
    @singer_notifications = SingerNotification.all
  end

  def show_recent_videos_notifications
    @singer_notifications = SingerNotification.where(singer_id: params[:singer_id], noti_status: :sent).order(read_at: :asc)
  end

  def update
    if @singer_notification.update!(read_at: Time.current)
      render json: @singer_notification
    else
      render json: @singer_notification.errors.messages, status: :unprocessable_entity
    end
  end

  private
  def set_notification
    @singer_notification = SingerNotification.find(params[:id])
  end
end
