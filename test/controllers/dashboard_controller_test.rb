require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    sign_in users(:admin_user)
    get dashboard_index_url
    assert_response :success
  end
end
