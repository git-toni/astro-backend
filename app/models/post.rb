class Post < ApplicationRecord
  belongs_to :telescope
  has_many :favorite_posts
  has_many :favorited_by, through: :favorite_posts, source: :user
end
