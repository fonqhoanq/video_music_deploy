class MemberNotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token  
  def index
    @member_notifications = MemberNotification.all
  end
end
