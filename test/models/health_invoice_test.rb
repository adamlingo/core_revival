require "test_helper"

class HealthInvoiceTest < ActiveSupport::TestCase
  FILE_NAME_WITH_REAL_INPUT_FORMAT='0000167878_07-01-2016_08-01-2016.csv'.freeze
  PATH_TO_ACTUAL_SUBSCRIBER_FILE = "#{Rails.root}/test/fixtures/#{FILE_NAME_WITH_REAL_INPUT_FORMAT}".freeze

  def health_invoice
    @health_invoice ||= HealthInvoice.new
  end

  def test_valid
    assert health_invoice.valid?
  end

  def test_negative_input
    expected = -24.55
    actual = HealthInvoice.convert_to_decimal("(24.55)")
    assert_equal expected.to_s, actual
  end

  def test_input
    expected = 100.55
    actual = HealthInvoice.convert_to_decimal(" $100.55 ")
    assert_equal expected.to_s, actual
  end

  def test_parse_date_from_file_name_correctly    
    file_name = '0000167878_07-01-2016_08-01-2016.csv'
    expected = Date.new(2016, 7, 1)

    actual = HealthInvoice.convert_to_date(file_name)
    assert_equal expected, actual
  end

  def test_load_actual_subscriber_file_correctly
    file = File.new(PATH_TO_ACTUAL_SUBSCRIBER_FILE)

    before = HealthInvoice.count

    HealthInvoice.import(file)

    after = HealthInvoice.count

    refute_equal after, before
  end
end
