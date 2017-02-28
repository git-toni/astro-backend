require 'test_helper'

class UserTest < ActiveSupport::TestCase
  po = Post.first
  u = User.all[0]
  u2 = User.all[1]
  test "favoriting a post correctly" do
    u.favorite_posts.create(post_id:po.id)  
    u2.favorite_posts.create(post_id:po.id)  
    assert po.favorited_by.include? u
    assert po.favorited_by.include? u2
    assert u.favorited_posts.include? po
  end
  test "favoriting the same post twice doesnt work" do
    u.favorite_posts.create(post_id:po.id)  
    exception = assert_raises(ActiveModel::StrictValidationFailed) do
      fp =u.favorite_posts.create(post_id:po.id)  
    end
    assert_equal exception.message, "User cannot favorite twice"
  end
end
