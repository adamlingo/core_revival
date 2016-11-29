# annualize:
# - monthly employee contribution
# - monthly employer contribution
# - monthly invoice amount
# calculate difference between "annualized" contributions and annualized invoice amount
class PayrollAnnualizer
  attr_reader :annualized_diff, :annualized_employee_contribution, :annualized_employer_contribution, :annualized_invoice_amount

  def initialize(monthly_invoice_amount, employee_monthly_contribution, employer_monthly_contribution, num_monthly_checks, pay_period)
    #@annualized_employee_contribution = employee_monthly_contribution*(52/num_monthly_checks)
    @annualized_employee_contribution = compute_annualized_employee_contribution(employee_monthly_contribution, num_monthly_checks, pay_period)
    @annualized_employer_contribution = 12*employer_monthly_contribution
    @annualized_invoice_amount = 12*monthly_invoice_amount
    @annualized_diff = (@annualized_employee_contribution + @annualized_employer_contribution) - @annualized_invoice_amount
  end

  private
    def compute_annualized_employee_contribution(employee_monthly_contribution, num_monthly_checks, pay_period)
      #(dollars/month)/(num_checks/month)
      converter = InvoiceConverter.new(employee_monthly_contribution, num_monthly_checks, pay_period)
      scaled_monthly = converter.to_monthly_expected_amount
      scaled_monthly*12
    end
end