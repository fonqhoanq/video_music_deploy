class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :video
  has_many :replies, dependent: :destroy
end
