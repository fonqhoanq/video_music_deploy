class MemberNotification < ApplicationRecord
  belongs_to :user
  belongs_to :video
  enum noti_status: {
    pending: 0,
    sent: 1,
    seen: 2,
    deleted: 3
  }
  enum noti_type: {
    recent_upload_video_notification: 0
  }
end
