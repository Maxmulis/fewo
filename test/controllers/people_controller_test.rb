require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    sign_in users(:admin_user)
    get people_url
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:admin_user)
    get new_household_person_url(households(:admin_household))
    assert_response :success
  end
end
