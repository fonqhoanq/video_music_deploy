json.array! @videos do |video|
    json.id video.id
    json.title video.title
    json.description video.description
    json.singer do
        json.singer_id video.singer.id
        json.channel_name video.singer.channel_name
    end
    json.created_at video.created_at
    json.public video.public
    json.views video.views
    json.url url_for(video.url) if video.url.attached?
    json.thumbnails url_for(video.thumbnails) if video.thumbnails.attached?
  end