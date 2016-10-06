require "test_helper"






class ReconciliationTest < ActiveSupport::TestCase

  def test_do_it_sub_fixed
    company_id = 1
    expected = ['Dana Demo Difference: 44.13']
    actual = Reconciliation.do_it(company_id)

    assert_equal expected, actual
  end

  def test_do_it_sub_percentage
    company_id = 2
    expected = ['Raymond Example Difference: -55.07']
    actual = Reconciliation.do_it(company_id)

    assert_equal expected, actual
  end

  # test data is valid
  
  # test dep calculates correctly
  
  # tests difference computation by reversing computation
  
  def setup 
    employees = [:alice, :blaze, :charlie] # Array of employees 
    benefit_detail = [:fixed, :%]
    companies= [:acme, :bovine]
  end
  
  def test_difference
      # @employees.each do |employee| 
      #   assert_equal(employee.employee?, True)
      # end
      
      # assert_equal difference + total_co_amount, insurance.amount
  end
  
  
  #  tests if all ee_deduct_amounts read from import
  
  def test_all_ee_deduct_amounts_read
      # assert_equal PayrollImport.sum("ee_deduct_amount"), Reconciliation.sum("ee_deduct_amount")
      # need to verify when
      # csv table is complete
  end
  
  #  tests if ee_deduction_converted by reversing computation
  
  def test_ee_deduction_converted_is_correct
    # if companies.number_pay_periods == 3
    #     assert_equal ee_deduction_converted * companies.number_pay_periods * 3, ee_deduction_converted
    # else
    #     assert_equal ee_deduct_amount, ee_deduction_converted
    # end
  end
  
  
  #  confirms er_pay is correct for FIXED employee.benefit_method =FIXED by 
  #  reversing computation
  
  def test_er_pay_fixed_is_correct
      # if employees.benefit_method == "FIXED"
      #     assert_equal employees.benefit_amount, er_pay
      # else
      #     assert_equal er_pay / insurance.amount, er_pay
      # end
  end
  

  #  tests total_co_amount by reversing computation
  
  def test_total_co_amount_is_correct
  end
  

end