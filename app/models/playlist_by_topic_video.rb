class PlaylistByTopicVideo < ApplicationRecord
  belongs_to :playlist_by_topic
  belongs_to :video
end
