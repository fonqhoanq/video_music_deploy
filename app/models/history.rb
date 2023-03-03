class History < ApplicationRecord
  belongs_to :user
  # belongs_to :video
  enum history_type: [:watch, :search]
end
