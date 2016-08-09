require "test_helper"

class HealthInvoiceTest < ActiveSupport::TestCase
  def health_invoice
    @health_invoice ||= HealthInvoice.new
  end

  def test_valid
    assert health_invoice.valid?
  end

  def test_negative_input
    expected = -24.55
    actual = health_invoice.convert_to_decimal("(24.55)")
    assert_equal expected.to_s, actual
  end

  def test_input
    expected = 100.55
    actual = health_invoice.convert_to_decimal(" $100.55 ")
    assert_equal expected.to_s, actual
  end
end
