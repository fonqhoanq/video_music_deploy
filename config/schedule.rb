every 1.day, at: '11:16 am' do
  runner "TrendingScore.new.execute"
end
every 1.day, at: '11:17 am' do
  runner "PlaylistByTopicBatch.new.execute_singer_topic"
end

every 1.day, at: '11:18 am' do
  runner "PlaylistByTopicBatch.new.execute_trending_topic"
end

every 1.day, at: '11:19 am' do
  runner "OwnPlaylistBatch.new.execute"
end
