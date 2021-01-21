class Murmur < ApplicationRecord

  belongs_to :user
  validates :body, presence: true, length: { maximum: 30 }

end
