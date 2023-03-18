json.array! @singer_videos do |singer_video|
    json.id singer_video.id
    json.title singer_video.title
    json.description singer_video.description
    json.singer do
        json.id singer_video.singer.id
        json.channelName singer_video.singer.channel_name
        json.avatarUrl url_for(singer_video.singer.avatar) if singer_video.singer.avatar.attached?
    end
    json.createdAt singer_video.created_at
    json.public singer_video.public
    json.views singer_video.views
    json.url url_for(singer_video.url) if singer_video.url.attached?
    json.thumbnails url_for(singer_video.thumbnails) if singer_video.thumbnails.attached?
end
