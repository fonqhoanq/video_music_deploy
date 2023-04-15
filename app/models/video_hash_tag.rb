class VideoHashTag < ApplicationRecord
  belongs_to :hash_tag
  belongs_to :video
end
  