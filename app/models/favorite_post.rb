class FavoritePost < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :user, uniqueness:{scope: :post, message:"cannot favorite twice"}, strict: true
end
