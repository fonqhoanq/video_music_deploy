json.array! @member_notifications do |member_notification|
  json.id member_notification.id
  json.content member_notification.content
  json.notiType member_notification.noti_type 
  json.createdAt member_notification.created_at
  json.avatarUrl url_for(member_notification.video.singer.avatar) if member_notification.video.singer.avatar.attached?
  json.thumbnails url_for(member_notification.video.thumbnails) if member_notification.video.thumbnails.attached?
  json.videoId member_notification.video_id
  json.readAt member_notification.read_at if member_notification.read_at.present?
end
