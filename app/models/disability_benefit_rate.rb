class DisabilityBenefitRate < ActiveRecord::Base
  belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id
  
  # COMPUTE BENEFIT RATES
  def self.get_employee_rate(employee_id, benefit_detail)
    rate = benefit_detail.category_sub
    employee = Employee.find(employee_id)
    salary = Salary.find_by(employee_id: employee.id)
    if salary.pay_type == "Annual Salary"
      puts "(((((((((((((((((((((((((((((((((((((((((((("
      puts salary.pay_type
      puts "(((((((((((((((((((((((((((((((((((((((((((("
    elsif salary.pay_type == ""
    end
    rate
  end
end