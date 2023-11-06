require "test_helper"

class HouseholdsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get households_new_url
    assert_response :success
  end

  test "should get edit" do
    get households_edit_url
    assert_response :success
  end

  test "should get show" do
    get households_show_url
    assert_response :success
  end
end
