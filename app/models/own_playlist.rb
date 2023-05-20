class OwnPlaylist < ApplicationRecord
  belongs_to :user
  has_many :own_playlist_videos, dependent: :destroy
  enum playlist_status: {
    unpublic: 0,
    unlisted: 1,
    is_public: 2
  }
end
  