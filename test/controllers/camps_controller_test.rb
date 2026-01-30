require 'test_helper'

class CampsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    sign_in users(:admin_user)
    get camps_url
    assert_response :success
  end

  test 'should get show' do
    sign_in users(:admin_user)
    get camp_url(camps(:one))
    assert_response :success
  end
end
