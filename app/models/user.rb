class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :subscribes
  has_many :feelings
  has_many :replies
  has_many :member_notifications
  has_many :user_playlists
  has_many :own_playlists
  has_one_attached :avatar
  enum gender: {
    male: 0,
    famale: 1,
  }
  validates :name, length: {minimum:3, maximum:40}
  validates :age, numericality: { only_numeric: true }
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  def self.ransackable_attributes(auth_object = nil)
    ["age", "authentication_token", "created_at", "email", "encrypted_password", "id", "gender", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
