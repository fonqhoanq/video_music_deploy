class Video < ApplicationRecord
  belongs_to :singer
  mount_uploader :url, VideoUploader
end
