class Reply < ApplicationRecord
  # belongs_to :singer
  belongs_to :comment
  belongs_to :user
end
