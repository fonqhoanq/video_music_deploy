class Feeling < ApplicationRecord
  belongs_to :user
  belongs_to :video
  enum status: [:dislike, :like]
end
