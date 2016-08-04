require "test_helper"

class HealthInvoiceTest < ActiveSupport::TestCase
  def health_invoice
    @health_invoice ||= HealthInvoice.new
  end

  def test_valid
    assert health_invoice.valid?
  end
end
