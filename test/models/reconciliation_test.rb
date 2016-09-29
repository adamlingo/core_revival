require "test_helper"

class ReconciliationTest < ActiveSupport::TestCase

  def test_do_it_sub_fixed
    company_id = 1
    expected = ['Demo, Dana Difference: 174.13']
    actual = Reconciliation.do_it(company_id)

    assert_equal expected, actual
  end

  def test_do_it_sub_percentage
    skip 'implement percentage!'
    company_id = 2
    expected = ['Example, Raymond Difference: -55.07']
    actual = Reconciliation.do_it(company_id)

    assert_equal expected, actual
  end
end