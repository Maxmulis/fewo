require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    sign_in users(:admin_user)
    get camp_registrations_url(camps(:one))
    assert_response :success
  end

  test 'should get new' do
    sign_in users(:admin_user)
    get new_camp_registration_url(camps(:one))
    assert_response :success
  end
end
