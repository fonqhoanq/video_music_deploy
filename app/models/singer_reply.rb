class SingerReply < ApplicationRecord
  belongs_to :singer
  belongs_to :comment
end
