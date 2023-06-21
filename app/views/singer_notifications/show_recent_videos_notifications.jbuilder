json.array! @singer_notifications do |singer_notification|
  json.id singer_notification.id
  json.content singer_notification.content
  json.createdAt singer_notification.created_at
  json.avatarUrl url_for(singer_notification.video.singer.avatar) if singer_notification.video.singer.avatar.attached?
  json.thumbnails url_for(singer_notification.video.thumbnails) if singer_notification.video.thumbnails.attached?
  json.videoId singer_notification.video_id
  json.readAt singer_notification.read_at if singer_notification.read_at.present?
end
