require 'test_helper'

class HouseholdTest < ActiveSupport::TestCase
  def valid_attributes
    {
      street: 'Hauptstrasse',
      number: '10',
      zip_code: '12345',
      town: 'Berlin',
      country_code: 'DE',
      recipient: 'Max Mustermann'
    }
  end

  test 'valid household should save' do
    household = Household.new(valid_attributes)
    assert household.valid?
    assert household.save
  end

  test 'requires street' do
    household = Household.new(valid_attributes.except(:street))
    assert_not household.valid?
    assert_includes household.errors[:street], "can't be blank"
  end

  test 'requires number' do
    household = Household.new(valid_attributes.except(:number))
    assert_not household.valid?
    assert_includes household.errors[:number], "can't be blank"
  end

  test 'requires zip_code' do
    household = Household.new(valid_attributes.except(:zip_code))
    assert_not household.valid?
    assert_includes household.errors[:zip_code], "can't be blank"
  end

  test 'requires town' do
    household = Household.new(valid_attributes.except(:town))
    assert_not household.valid?
    assert_includes household.errors[:town], "can't be blank"
  end

  test 'requires country_code' do
    household = Household.new(valid_attributes.except(:country_code))
    assert_not household.valid?
    assert_includes household.errors[:country_code], "can't be blank"
  end

  test 'requires recipient' do
    household = Household.new(valid_attributes.except(:recipient))
    assert_not household.valid?
    assert_includes household.errors[:recipient], "can't be blank"
  end

  test 'validates zip_code format' do
    household = Household.new(valid_attributes.merge(zip_code: 'ABC123'))
    assert_not household.valid?
    assert_includes household.errors[:zip_code], 'must be 4-10 digits'
  end

  test 'accepts valid zip_code formats' do
    ['1234', '12345', '1234567890'].each do |zip|
      household = Household.new(valid_attributes.merge(zip_code: zip))
      assert household.valid?, "#{zip} should be valid"
    end
  end

  test 'validates country_code format' do
    household = Household.new(valid_attributes.merge(country_code: 'DEU'))
    assert_not household.valid?
    assert_includes household.errors[:country_code], 'must be 2 uppercase letters (ISO code)'
  end

  test 'normalizes country_code to uppercase' do
    household = Household.create!(valid_attributes.merge(country_code: 'de'))
    assert_equal 'DE', household.country_code
  end

  test 'prevents duplicate addresses with same recipient' do
    Household.create!(valid_attributes)
    duplicate = Household.new(valid_attributes)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:street], 'household with this address and recipient already exists'
  end

  test 'allows same address with different recipients' do
    Household.create!(valid_attributes)
    different_recipient = Household.new(valid_attributes.merge(recipient: 'Familie Schmidt'))
    assert different_recipient.valid?
    assert different_recipient.save
  end

  test 'allows same street in different towns' do
    Household.create!(valid_attributes)
    different_town = Household.new(valid_attributes.merge(town: 'Hamburg'))
    assert different_town.valid?
  end

  test 'find_similar finds exact matches case-insensitively' do
    household = Household.create!(valid_attributes)

    similar = Household.find_similar(
      street: 'hauptstrasse',
      number: '10',
      zip_code: '12345',
      town: 'BERLIN',
      country_code: 'de'
    )

    assert_equal 1, similar.count
    assert_equal household.id, similar.first.id
  end

  test 'find_similar does not find non-matching addresses' do
    Household.create!(valid_attributes)

    similar = Household.find_similar(
      street: 'Nebenstrasse',
      number: '10',
      zip_code: '12345',
      town: 'Berlin',
      country_code: 'DE'
    )

    assert_equal 0, similar.count
  end

  test 'full_address returns formatted address string' do
    household = Household.new(valid_attributes)
    assert_equal 'Hauptstrasse 10, 12345 Berlin, DE', household.full_address
  end
end
