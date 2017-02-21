require 'test_helper'

class TelescopesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @telescope = telescopes(:one)
  end

  test "should get index" do
    get telescopes_url, as: :json
    assert_response :success
  end

  test "should create telescope" do
    assert_difference('Telescope.count') do
      post telescopes_url, params: { telescope: { cospar_id: @telescope.cospar_id, name: @telescope.name, operator: @telescope.operator, regime: @telescope.regime } }, as: :json
    end

    assert_response 201
  end

  test "should show telescope" do
    get telescope_url(@telescope), as: :json
    assert_response :success
  end

  test "should update telescope" do
    patch telescope_url(@telescope), params: { telescope: { cospar_id: @telescope.cospar_id, name: @telescope.name, operator: @telescope.operator, regime: @telescope.regime } }, as: :json
    assert_response 200
  end

  test "should destroy telescope" do
    assert_difference('Telescope.count', -1) do
      delete telescope_url(@telescope), as: :json
    end

    assert_response 204
  end
end
