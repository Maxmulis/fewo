require 'test_helper'

class HouseholdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = Person.create!(
      first_name: 'Test',
      name: 'User',
      dob: Date.new(1990, 1, 1)
    )
    @user = User.create!(
      email: 'test@example.com',
      password: 'password123',
      person: @person,
      admin: true
    )
    post user_session_path, params: { user: { email: @user.email, password: 'password123' } }
  end

  def valid_household_params
    {
      household: {
        street: 'Teststrasse',
        number: '42',
        zip_code: '12345',
        town: 'Berlin',
        country_code: 'DE',
        recipient: 'Test Familie'
      }
    }
  end

  test 'should get new' do
    get new_household_url
    assert_response :success
    assert_select 'h1', 'Neuen Haushalt anlegen'
  end

  test 'should create household with valid data' do
    assert_difference('Household.count') do
      post households_url, params: valid_household_params
    end

    assert_redirected_to household_path(Household.last)
    assert_equal 'Haushalt wurde erfolgreich erstellt.', flash[:success]
  end

  test 'should not create household with invalid data' do
    assert_no_difference('Household.count') do
      post households_url, params: { household: { street: '' } }
    end

    assert_response :unprocessable_entity
    assert_not_nil flash.now[:alert]
  end

  test 'should prevent duplicate household with same recipient' do
    Household.create!(
      street: 'Teststrasse',
      number: '42',
      zip_code: '12345',
      town: 'Berlin',
      country_code: 'DE',
      recipient: 'Test Familie'
    )

    assert_no_difference('Household.count') do
      post households_url, params: valid_household_params
    end

    assert_response :unprocessable_entity
    assert flash[:alert].include?('bereits') || flash[:alert].include?('exist')
  end

  test 'should show similar households warning when checking address' do
    existing = Household.create!(
      street: 'Teststrasse',
      number: '42',
      zip_code: '12345',
      town: 'Berlin',
      country_code: 'DE',
      recipient: 'Familie Müller'
    )

    get new_household_url, params: {
      household: {
        street: 'Teststrasse',
        number: '42',
        zip_code: '12345',
        town: 'Berlin',
        country_code: 'DE'
      }
    }

    assert_response :success
    assert_select 'div.alert-warning', /Ähnliche Haushalte/
    assert_select 'a', text: 'Familie Müller'
  end

  test 'should allow different recipients at same address' do
    Household.create!(
      street: 'Teststrasse',
      number: '42',
      zip_code: '12345',
      town: 'Berlin',
      country_code: 'DE',
      recipient: 'Familie Müller'
    )

    assert_difference('Household.count') do
      post households_url, params: {
        household: {
          street: 'Teststrasse',
          number: '42',
          zip_code: '12345',
          town: 'Berlin',
          country_code: 'DE',
          recipient: 'Familie Schmidt'
        }
      }
    end

    assert_redirected_to household_path(Household.last)
  end

  test 'should get edit' do
    household = Household.create!(
      street: 'Teststrasse',
      number: '42',
      zip_code: '12345',
      town: 'Berlin',
      country_code: 'DE',
      recipient: 'Test Familie'
    )

    get edit_household_url(household)
    assert_response :success
  end

  test 'should update household with valid data' do
    household = Household.create!(
      street: 'Teststrasse',
      number: '42',
      zip_code: '12345',
      town: 'Berlin',
      country_code: 'DE',
      recipient: 'Test Familie'
    )

    patch household_url(household), params: {
      household: { recipient: 'Neue Familie' }
    }

    assert_redirected_to edit_household_path(household)
    household.reload
    assert_equal 'Neue Familie', household.recipient
  end

  test 'should show household' do
    household = Household.create!(
      street: 'Teststrasse',
      number: '42',
      zip_code: '12345',
      town: 'Berlin',
      country_code: 'DE',
      recipient: 'Test Familie'
    )

    get household_url(household)
    assert_response :success
  end
end
