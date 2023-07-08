json.array! videos do |video|
  json.id video.id
  json.title video.title
  json.description video.description
  json.singer do
    json.id video.singer.id
    json.channelName video.singer.channel_name
    json.avatarUrl url_for(video.singer.avatar) if video.singer.avatar.attached?
  end
  json.createdAt video.created_at
  json.public video.video_status == 'is_public'
  json.views video.views
  json.url url_for(video.url) if video.url.attached?
  json.thumbnails url_for(video.thumbnails) if video.thumbnails.attached?
  json.likes video.feeling.where(:status => 'like').count
  json.dislikes video.feeling.where(:status => 'dislike').count
  json.comments video.comments.count
  json.status video.video_status
  json.status_text 'Public' if video.video_status == 'is_public'
  json.status_text 'Private' if video.video_status == 'unpublic'
  json.status_text 'Scheduling' if video.video_status == 'scheduling'
  json.upload_video_at video.upload_video_at
  # json.comments video.comment.count
end
