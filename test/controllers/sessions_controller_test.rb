require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  u = User.first
  test "should get dummy response" do
    post login_path,params: {auth:{email: u.email, password:123123}}
    #get dummy_path
    #get_auth dummy_path, @@jwt
    #res = HashWithIndifferentAccess.new JSON.parse(@response.body)
    res = JSON.parse(@response.body)
    assert_response :success
    assert res['jwt']#, 'Dummy sent'
  end
end
