require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  u = User.first
  @@jwt = JwtFactory.create(u)
  @@expjwt = JwtFactory.create(u,2.hours.ago.to_i) #expired jwt
  test "should get dummy response" do
    #get dummy_path
    get_auth dummy_path, @@jwt
    #res = HashWithIndifferentAccess.new JSON.parse(@response.body)
    res = JSON.parse(@response.body)
    #binding.pry
    assert_response :success
    assert res['msg'], 'Dummy sent'
  end
  test "should get expired token" do
    #get dummy_path
    get_auth dummy_path, @@expjwt
    #res = HashWithIndifferentAccess.new JSON.parse(@response.body)
    res = JSON.parse(@response.body)
    assert_response :unauthorized
    assert res.include? 'msg'
    assert res['msg'].include?'Expired Token'
  end
end
