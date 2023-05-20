class OwnPlaylistVideo < ApplicationRecord
  belongs_to :video
  belongs_to :own_playlist
end
    