json.array! @videos do |video|
    json.id video.id
    json.title video.title
    json.description video.description
    json.url video.url
    json.singer_id video.singer_id
    json.created_at video.created_at
  end