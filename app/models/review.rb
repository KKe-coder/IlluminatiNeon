class Review < ApplicationRecord

  belongs_to :user
  belongs_to :post
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 5}
  validates :comment, presence: true, length: { maximum: 20 }
end
