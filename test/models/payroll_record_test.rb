require "test_helper"

class PayrollRecordTest < ActiveSupport::TestCase
  def payroll_record
    @payroll_record ||= PayrollRecord.new
  end

  def test_valid
    skip
    # assert payroll_record.valid?
  end
end
