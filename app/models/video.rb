class Video < ApplicationRecord
  belongs_to :singer
  has_one_attached :url
  enum category_id: {pop: 0, rock: 1}
end
