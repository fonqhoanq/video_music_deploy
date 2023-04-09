class UserPlaylist < ApplicationRecord
  belongs_to :playlist
  belongs_to :user
end
