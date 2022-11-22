json.array! @singers do |singer|
    json.id singer.id
    json.name singer.name
    json.email singer.email
    json.channel_name singer.channel_name
    json.age singer.age
    json.created_at singer.created_at
  end