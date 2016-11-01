class PayrollAnnualizer

  def initialize(monthy_invoice_amount, num_monthly_periods, pay_period)
    @monthy_invoice_amount = monthy_invoice_amount
    @num_monthly_periods = num_monthly_periods
    @pay_period = pay_period
  end

  def annualize
    case @pay_period
    when 'monthly'
      compute_monthly_expected(@monthy_invoice_amount, 1, 12)
    when 'semi-monthly'
      compute_monthly_expected(@monthy_invoice_amount, 2, 24)
    when 'bi-weekly'
      case @num_monthly_periods
      when 2
        compute_monthly_expected(@monthy_invoice_amount, 2, 26)
     when 3
        compute_monthly_expected(@monthy_invoice_amount, 3, 26)
      else
        raise StandardError.new "Invalid number of monthly pay periods for bi-weekly pay: #{@num_monthly_periods}"
      end 
    when 'weekly'
      case @num_monthly_periods
      when 4
        compute_monthly_expected(@monthy_invoice_amount, 4, 52)
      when 5
        compute_monthly_expected(@monthy_invoice_amount, 5, 52)
      else
        raise StandardError.new "Invalid number of monthly pay periods for weekly pay: #{@num_monthly_periods}"
      end 
    else
      raise StandardError.new "Unknown pay period: #{@pay_period}"
    end
  end

  private
    def compute_monthly_expected(monthly_amount, num_monthly_checks, num_yearly_checks)
      (monthly_amount*12)*(num_monthly_checks)/num_yearly_checks
    end
end