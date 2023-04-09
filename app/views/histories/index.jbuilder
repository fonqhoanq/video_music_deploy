json.array! @histories do |history|
  json.id history.id
  json.user do
    json.username history.user.name
  end
  if history.video.present?
    json.video do
      json.title history.video.title
      json.description history.video.description
      json.thumbnails url_for(history.video.thumbnails) if history.video.thumbnails.attached?
      json.views history.video.views
      json.singer do
        json.channelName history.video.singer.channel_name
      end
    end
  end
  if history.search_text.present?
      json.searchText history.search_text
  end
  json.createdAt history.created_at
end
