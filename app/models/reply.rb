class Reply < ApplicationRecord
  belongs_to :singer
  belongs_to :video
  belongs_to :comment
end
