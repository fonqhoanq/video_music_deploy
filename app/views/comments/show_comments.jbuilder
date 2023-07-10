json.array! @comments do |comment|
  json.id comment.id
  json.text comment.text
  json.user do
    json.id comment.user.id
    json.username comment.user.name
    json.avatarUrl url_for(comment.user.avatar) if comment.user.avatar.attached? 
  end
  json.replies comment.replies do |reply|
    json.id reply.id
    json.text reply.text
    json.singerId reply.singer_id
    json.user do
      json.id reply.user.id
      json.username reply.user.name
      json.avatarUrl url_for(reply.user.avatar) if reply.user.avatar.attached? 
    end
    json.createdAt reply.created_at
  end

  json.singer_replies comment.singer_replies do |reply|
    json.id reply.id
    json.text reply.text
    json.singer do
      json.id reply.singer.id
      json.username reply.singer.channel_name
      json.avatarUrl url_for(reply.singer.avatar) if reply.singer.avatar.attached? 
    end
    json.createdAt reply.created_at
  end
  json.createdAt comment.created_at
end
