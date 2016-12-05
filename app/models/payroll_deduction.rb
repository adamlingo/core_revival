class PayrollDeduction < ActiveRecord::Base
  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |payroll_deduction|
        csv << payroll_deduction.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file, month = nil, year = nil)
    payroll_deductions = []

    CSV.foreach(file.path, headers: true) do |row|
      payroll_hash = row.to_hash

      # all columns in Payroll Deduction csv
      unless payroll_hash['Employee ID'].nil?
        payroll_deduction = find_or_create_by!(pay_ee_id: payroll_hash['Employee ID'],
                                            pay_sub_name: payroll_hash['Employee Name'],
                                            pay_sub_id: payroll_hash['Subscriber  #   '],
                                            pay_category: payroll_hash['Category#'],
                                            deduction_amount: payroll_hash['Amount'],
                                            month: month,
                                            year: year)
        payroll_deduction.save!
        payroll_deductions << payroll_deduction
      end
    end
    payroll_deductions
  end

  def to_s
    "pay_ee_id: #{self.pay_ee_id}\npay_sub_name: #{self.pay_sub_name}\npay_sub_id: #{self.pay_sub_id}\npay_category: #{self.pay_category}\ndeduction_amount: #{self.deduction_amount}\nmonth: #{self.month}\nyear: #{self.year}"
  end
end
