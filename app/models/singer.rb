class Singer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  has_many :videos, dependent: :destroy
  has_many :subscribes, dependent: :destroy
  has_many :singer_notifications
  has_many :singer_replies
  # has_many :replies
  has_one_attached :avatar
  def self.ransackable_attributes(auth_object = nil)
    ["age", "authentication_token", "channel_name", "created_at", "email", "encrypted_password", "id", "music_type", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
