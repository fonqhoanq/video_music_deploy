class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :video
  has_many :replies, dependent: :destroy
  has_many :singer_replies, dependent: :destroy
  enum status: {
    unanswered: 0,
    answered: 1
  }
end
