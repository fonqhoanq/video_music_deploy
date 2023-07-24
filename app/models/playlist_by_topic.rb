class PlaylistByTopic < ApplicationRecord
  has_many :playlist_by_topic_videos, dependent: :destroy
  enum playlist_type: {
    singer_topic: 0,
    trending_topic: 1,
    new_release_topic: 2
  }
end
