json.array!(@payroll_deductions) do |payroll_deduction|
  json.extract! payroll_deduction, :id
  json.url payroll_deduction_url(payroll_deduction, format: :json)
end
