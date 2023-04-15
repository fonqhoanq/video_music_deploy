class HashTag < ApplicationRecord
  has_many :playlists
  has_many :video_hash_tag
end
