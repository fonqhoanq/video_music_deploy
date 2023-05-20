class Video < ApplicationRecord
  belongs_to :singer
  belongs_to :category
  has_many :video_hash_tags, dependent: :destroy
  has_one_attached :url
  has_one_attached :thumbnails
  has_many :feeling, dependent: :destroy
  has_many :member_notifications, dependent: :destroy
  has_many :playlist_videos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :own_playlist_videos, dependent: :destroy
  enum video_status: {
    unpublic: 0,
    is_public: 1,
    scheduling: 2
  }

  def upload_video_at
    uploaded_video_at || VideoService.new(self).scheduled_at
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "public", "singer_id", "title", "updated_at", "views"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["feeling", "singer", "thumbnails_attachment", "thumbnails_blob", "url_attachment", "url_blob"]
  end
  # validates :title, length: {minimum: 10, maximum: 100}
  # validates :description, length: {minimum: 30, maximum: 1000}
end
