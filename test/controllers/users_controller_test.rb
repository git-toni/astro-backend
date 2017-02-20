require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  @@jwt = JwtFactory.create(User.first)
  test "should get index" do
    get_auth users_index_url, @@jwt
    assert_response :success
  end
end
