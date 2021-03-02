class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post

  #1ユーザー1favoriteまで
  validates_uniqueness_of :post_id, scope: :user_id
end
