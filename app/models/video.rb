class Video < ApplicationRecord
  belongs_to :singer
  has_one_attached :url
  has_one_attached :thumbnails
  has_many :feeling
  enum category_id: {
    pop: 0,
    rock: 1, 
    country_music: 3, 
    electronic: 4, 
    funk: 5, 
    hip_hop: 6, 
    jazz: 7, 
    latin: 8, 
    soul: 9, 
    r_b: 10
  }
  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "public", "singer_id", "title", "updated_at", "views"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["feeling", "singer", "thumbnails_attachment", "thumbnails_blob", "url_attachment", "url_blob"]
  end
  # validates :title, length: {minimum: 10, maximum: 100}
  # validates :description, length: {minimum: 30, maximum: 1000}
end
