require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  u = User.all[0]
  u2 = User.all[1]
  @@jwt = JwtFactory.create(u)
  test "should get name/email of SELF profile" do
    get_auth user_profile_url(u), @@jwt
    res = JSON.parse(@response.body)
    assert_response :success
    assert res.include? 'name'
    assert res.include? 'email'
    assert_equal res['name'], u.name
  end
  test "should get only name of SELF profile" do
    get_auth user_profile_url(u2), @@jwt
    res = JSON.parse(@response.body)
    assert_response :success
    assert res.include? 'name'
    assert_not res.include? 'email'
    assert_not_equal res['name'], u.name
  end
  test "access OWN settings correctly" do
    get_auth user_settings_url(u), @@jwt
    assert_response :success
    res = JSON.parse(@response.body)
    assert res.include? 'display_preferences'
    assert res.include? 'notification_preferences'
  end
  test "accessing OTHERS' settings unauthorized" do
    get_auth user_settings_url(u2), @@jwt
    assert_response :unauthorized
    res = JSON.parse(@response.body)
    assert res.include? 'msg'
    assert_equal res['msg'], "Can't access other's settings"
  end
end
