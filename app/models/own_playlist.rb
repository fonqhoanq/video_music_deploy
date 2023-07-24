class OwnPlaylist < ApplicationRecord
  belongs_to :user
  has_many :own_playlist_videos, dependent: :destroy
  enum playlist_status: {
    unpublic: 0,
    unlisted: 1,
    is_public: 2
  }
  enum playlist_type: {
    individual_playlist: 0,
    mix_playlist: 1,
    daily_playlist: 2,
  }
end
  