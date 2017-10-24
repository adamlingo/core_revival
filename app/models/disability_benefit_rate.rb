class DisabilityBenefitRate < ActiveRecord::Base
  belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id
  
  # COMPUTE BENEFIT RATES
  def self.get_employee_rate(employee_id, benefit_detail)
    current_monthly_rate = benefit_detail.category_sub
    employee = Employee.find(employee_id)
    current_salary = Salary.where(employee_id: employee.id).sort_by{|sal| [sal.start_date]}.reverse.first
    # re-route if salary not entered, check floats in future
    if current_salary.present? && current_salary.pay_type == "Annual Salary"
      monthly_salary = (current_salary.rate.to_f / 12.00).round(2)
      coverage_amount = (monthly_salary * current_monthly_rate) / (100).round(2)

       # Console puts log to show calculations
      puts "(((((((((((((((((((((((((((((((((((((((((((("
      puts current_salary.pay_type
      puts current_salary.rate
      puts monthly_salary
      puts "(((((((((((((((((((((((((((((((((((((((((((("
    elsif current_salary.present? && current_salary.pay_type == ""
      # Future computations based on hourly wages if applicable for Disability Ins.
    end
    # Return cost to subscriber
    coverage_amount
  end
end