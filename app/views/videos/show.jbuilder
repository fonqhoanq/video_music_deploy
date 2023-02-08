json.id @video.id
json.title @video.title
json.description @video.description
json.singer do
    json.id @video.singer.id
    json.channelName @video.singer.channel_name
end
json.createdAt @video.created_at
json.public @video.public
json.views @video.views
json.url url_for(@video.url) if @video.url.attached?
json.thumbnails url_for(@video.thumbnails) if @video.thumbnails.attached?
json.likes @video.feeling.where(:status => 'like').count
json.dislikes @video.feeling.where(:status => 'dislike').count  

