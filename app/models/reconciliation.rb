# for each employee, using defined terms below, reconcile the health_invoice amount to
# the total company amount
class Reconciliation < ActiveRecord::Base

    def initialize(company_id, month, year)
        @company_id = company_id
        @company = Company.find(company_id)
        @month = month
        @year = year
        @payroll_periods = PayrollPeriod.where(month: @month, year: @year, company_id: @company_id)
        @num_payroll_periods = @payroll_periods.count
        if @num_payroll_periods == 0
            @pay_period = 'N/A'
        else
            @pay_period = @payroll_periods[0].pay_period
        end

    end

    def calculate
        results = find_invoices_without_matching_employee
        results.push("No payroll periods for month:  #{@month}, year: #{@year}, company_id: #{@company_id}") if @payroll_periods.empty?

        employees = @company.employees

        employees.each {|employee|
          if (employee.sub_id.present?)
              diff = calculate_diff(employee)
              if diff.is_a?(Array)
                  results.push("#{employee.last_name}, #{employee.first_name} - Annualized: #{diff[0]}; Monthly: #{diff[1]}")
              else
                  results.push("#{employee.last_name}, #{employee.first_name} - #{diff}")
              end
          else
              results.push("#{employee.last_name}, #{employee.first_name} -  Employee.sub_id is not set!")
          end
        }
        results
    end

    def self.do_it(company_id, month, year)
        puts "reconciliation -- company_id: #{company_id}; month: #{month}; year: #{year}"
        reconciliation = Reconciliation.new(company_id, month, year)
        reconciliation.calculate
    end

    private

        def calculate_diff(employee)

            emp_invoices = HealthInvoice.where(health_sub_id: employee.sub_id, month: @month, year: @year)
            return "No Invoices for month: #{@month} year: #{@year}" if emp_invoices.nil? || emp_invoices.count == 0

            # this grabs every payroll row for the specific employee for the specific month/year
            emp_payroll_deduction = PayrollDeduction.where(pay_sub_id: employee.sub_id, month: @month, year: @year).sum(:deduction_amount)

            # get the account number from the invoices
            insurance_account_number = emp_invoices[0].account_number

            # benefit details for the employee
            benefit_selection = employee_benefit_selection(insurance_account_number, employee)
            return 'benefit declined' if benefit_selection.decline_benefit

            benefit_detail = BenefitDetail.find(benefit_selection.benefit_detail_id)

            # this is the actual amount payroll deducted
            employee_contribution = emp_payroll_deduction

            sub_invoice_total = health_invoice_sub_charges(emp_invoices)
            dep_invoice_total = health_invoice_dep_charges(emp_invoices)

            # employer contributions
            employer_contribution_subscriber = employer_contribution_sub(benefit_detail, sub_invoice_total)
            employer_contribution_dependent = employer_contribution_dep(benefit_detail, dep_invoice_total)
            employer_contribution =  employer_contribution_subscriber + employer_contribution_dependent

            # We expect only one insurance invoice per month.
            # We also expect only one payroll deduction report per month.
            # However payroll deductions could be up to 5 payments aggregated!
            # So we need to annualize the pay deductions to compare against the monthly invoice rates
            # So we need to look at the number of payroll periods to know how to annualize a monthly deduction

            # Ultimately for a given month the difference should be zero.
            # but it might also be worth annualizing both the monthly invoice and payroll deduction and reporting those differences...
            invoice_total = sub_invoice_total + dep_invoice_total
            sum_total = emp_invoices.sum(:total_charges)
            raise StandardError.new ("Totals do not match for sub_id #{employee.sub_id}: invoice_total: #{invoice_total}; sum_total: #{sum_total}") if invoice_total != sum_total
            expected_monthly_deduction_for_invoice = InvoiceConverter.new(invoice_total, @num_payroll_periods, @payroll_periods[0].pay_period).to_monthly_expected_amount

            annualizer = PayrollAnnualizer.new(invoice_total, employee_contribution, employer_contribution, @num_payroll_periods, @pay_period)
            monthly_diff = (employee_contribution + employer_contribution) - expected_monthly_deduction_for_invoice

            puts "-----------------------------------------------"
            puts "#{employee.last_name}, #{employee.first_name}"
            puts "employee subscriber_id: #{employee.sub_id}"
            puts "num_payroll_periods: #{@num_payroll_periods}"
            puts "pay_period: #{@pay_period}"
            puts "invoice_total: #{invoice_total.truncate(2)}"
            puts "sub_invoice_total: #{sub_invoice_total.truncate(2)}"
            puts "dep_invoice_total: #{dep_invoice_total.truncate(2)}"
            puts "employer_contribution total: #{employer_contribution.truncate(2)}"
            puts "employer_contribution_subscriber: #{employer_contribution_subscriber.truncate(2)}"
            puts "employer_contribution_dependent: #{employer_contribution_dependent.truncate(2)}"
            puts "employee_contribution: #{employee_contribution.truncate(2)}"
            puts "expected_monthly_deduction_for_invoice: #{expected_monthly_deduction_for_invoice.truncate(2)}"
            puts "monthly_diff => (employer_contribution + employee_contribution) - expected_monthly_deduction_for_invoice: #{monthly_diff.truncate(2)}"
            puts "annualizer.annualized_invoice_amount: #{annualizer.annualized_invoice_amount.truncate(2)}"
            puts "annualizer.annualized_employer_contribution: #{annualizer.annualized_employer_contribution.truncate(2)}"
            puts "annualizer.annualized_employee_contribution: #{annualizer.annualized_employee_contribution.truncate(2)}"
            puts "annualizer.annualized_diff => (annualizer.annualized_employee_contribution + annualizer.annualized_employer_contribution) - annualizer.annualized_invoice_amount: #{annualizer.annualized_diff.truncate(2)}"
            puts "-----------------------------------------------"

            [annualizer.annualized_diff.truncate(2), monthly_diff.truncate(2)]
        end

        def employee_benefit_selection(insurance_account_number, employee_id)
            benefit_profiles = @company.benefit_profiles.where(account_number: insurance_account_number)
            raise StandardError.new("No benefit_profiles found for insurance_account_number: #{insurance_account_number}") if benefit_profiles.count == 0
            raise StandardError.new("Should only have one benefit_profiles for a given insurance_account_number: #{insurance_account_number}") if benefit_profiles.count != 1

            benefit_profile = benefit_profiles.first
            benefit_selections = EmployeeBenefitSelection.where(employee_id: employee_id, benefit_type: benefit_profile.benefit_type)

            raise StandardError.new("No benefit_selection found for employee id: #{employee_id} insurance_account_number: #{insurance_account_number} benefit_type: #{benefit_profile.benefit_type}") if benefit_selections.count == 0
            raise StandardError.new("Should only have one benefit_selection for a given employee id: #{employee_id} insurance_account_number: #{insurance_account_number} benefit_type: #{benefit_profile.benefit_type}") if benefit_selections.count != 1
            benefit_selections.first
        end

        def health_invoice_sub_charges(emp_invoices)
            total = BigDecimal.new("0.0")
            emp_invoices.each {|inv|
                total += inv.total_charges if inv.tier == 'SUB'
            }

            total
        end

        def health_invoice_dep_charges(emp_invoices)
            total = BigDecimal.new("0.0")
            emp_invoices.each {|inv|
                total += inv.total_charges if inv.tier != 'SUB'
            }

            total
        end

        def employer_contribution_sub(employee_benefit_detail, sub_invoice_total)
          
            if employee_benefit_detail.benefit_method == 'FIXED'
                employee_benefit_detail.category_sub
            else
                employee_benefit_detail.category_sub * sub_invoice_total  
            end
        end

        def employer_contribution_dep(employee_benefit_detail, dep_invoice_total)
            # for now we are assuming all dependents are treated the same (so we're ignoring the other columns on the table for now)
            if employee_benefit_detail.benefit_method == 'FIXED'
                employee_benefit_detail.category_dep
            else
                employee_benefit_detail.category_dep * dep_invoice_total
            end
        end

        def find_invoices_without_matching_employee
            info = []
            HealthInvoice.where(month: @month, year: @year, tier: 'SUB').each {|inv|
                emp = Employee.find_by(sub_id: inv.health_sub_id, company_id: @company_id)
                if emp.nil?
                    info.push("Employee not found! Name: #{inv.sub_name}; subscriber id: #{inv.health_sub_id}")
                end
            }
            info
        end
end