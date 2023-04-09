class Playlist < ApplicationRecord
  has_many :playlist_videos
  has_many :user_playlists
  belongs_to :hash_tag
end
