class PayrollDeduction < ActiveRecord::Base
  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |payroll_deduction|
        csv << payroll_deduction.attributes.values_at(*fields)
      end
    end
  end



end
