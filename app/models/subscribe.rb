class Subscribe < ApplicationRecord
  belongs_to :singer
  belongs_to :user
  enum status: [:unsubscribe, :subscribe]
end
