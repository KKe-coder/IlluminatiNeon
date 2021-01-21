class Contact < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 30 }
  validates :message, presence: true, length: { maximum: 200 }
end
