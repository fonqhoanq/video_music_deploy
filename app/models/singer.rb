class Singer < ApplicationRecord
  has_many :videos
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save :downcase_email

  validates :name, presence: true
  validates :channel_name, presence: true
  validates :age, presence: true, numericality: { greater_than: 0}
  validates :email, presence: true, length: {minimum:10, maximum:255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

  # has_secure_password
  private
  def downcase_email
    self.email.downcase!
  end
end
