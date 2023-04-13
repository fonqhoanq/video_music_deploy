class Video < ApplicationRecord
  belongs_to :singer
  belongs_to :category
  has_one_attached :url
  has_one_attached :thumbnails
  has_many :feeling
  has_many :member_notifications
  has_many :playlist_videos
  has_many :comments
  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "public", "singer_id", "title", "updated_at", "views"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["feeling", "singer", "thumbnails_attachment", "thumbnails_blob", "url_attachment", "url_blob"]
  end
  # validates :title, length: {minimum: 10, maximum: 100}
  # validates :description, length: {minimum: 30, maximum: 1000}
end
