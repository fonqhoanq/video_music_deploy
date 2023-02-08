class Video < ApplicationRecord
  belongs_to :singer
  has_one_attached :url
  has_one_attached :thumbnails
  has_many :feeling
  enum category_id: {pop: 0, rock: 1}
  # validates :title, length: {minimum: 10, maximum: 100}
  # validates :description, length: {minimum: 30, maximum: 1000}
end
