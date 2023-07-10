json.array! @comments do |comment|
  json.id comment.id
  json.comment comment.text
  json.user_name comment.user.name
  json.video_title comment.video.title
  json.thumbnails url_for(comment.video.thumbnails)
  json.createdAt comment.video.created_at
  json.views comment.video.views
  json.created_at comment.created_at
  json.status comment.status == "unanswered" ? "Unanswered" : "Answered"
end
