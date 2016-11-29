require 'rails_helper'

describe PayrollAnnualizer, type: :model do

  context 'employer pays 50%' do
    before(:each) do
      @monthly_invoice_amount = 356.35
      @monthly_employer_contribution = @monthly_invoice_amount/2.0
      @annualized_invoice_amount = @monthly_invoice_amount*12.0
    end

    context 'monthly' do
      it 'should return 0' do
        employee_contribution = @monthly_invoice_amount/2
        num_checks = 1

        annualizer = PayrollAnnualizer.new(@monthly_invoice_amount, employee_contribution, @monthly_employer_contribution, num_checks, 'monthly')
        expect(annualizer.annualized_invoice_amount).to eq(@annualized_invoice_amount)
        expect(annualizer.annualized_employer_contribution).to be_within(0.01).of(2138.1)
        expect(annualizer.annualized_employee_contribution).to be_within(0.01).of(2138.1)
        expect(annualizer.annualized_diff).to eq(0)
      end
    end

    context 'semi-monthly' do
      it 'should return 0' do
        employee_contribution = @monthly_invoice_amount/2.0
        num_checks = 2

        annualizer = PayrollAnnualizer.new(@monthly_invoice_amount, employee_contribution, @monthly_employer_contribution, num_checks, 'semi-monthly')

        expect(annualizer.annualized_invoice_amount).to eq(@annualized_invoice_amount)
        expect(annualizer.annualized_employer_contribution).to be_within(0.01).of(2138.1)
        expect(annualizer.annualized_employee_contribution).to be_within(0.01).of(2138.1)
        expect(annualizer.annualized_diff).to eq(0)
      end
    end

    context 'weekly' do

      it 'should return 0 for 4 pay checks' do
        # Villemarette IV, Joseph
        # employee subscriber_id: 820832618
        # num_payroll_periods: 4
        # pay_period: weekly
        # invoice_total: 356.35
        # sub_invoice_total: 356.35
        # dep_invoice_total: 0.0
        # employer_contribution total: 178.17
        # employer_contribution_subscriber: 178.17
        # employer_contribution_dependent: 0.0
        # employee_contribution: 164.48
        # expected_monthly_deduction_for_invoice: 328.93
        # monthly_diff => (employer_contribution + employee_contribution) - expected_monthly_deduction_for_invoice: 13.71
        # annualizer.annualized_invoice_amount: 4276.2
        # annualizer.annualized_employer_contribution: 2138.1
        # annualizer.annualized_employee_contribution: 2138.24
        # annualizer.annualized_diff => (annualizer.annualized_employee_contribution + annualizer.annualized_employer_contribution) - annualizer.annualized_invoice_amount: 0.14

        employee_contribution = 164.48
        num_checks = 4

        annualizer = PayrollAnnualizer.new(@monthly_invoice_amount, employee_contribution, @monthly_employer_contribution, num_checks, 'weekly')

        expect(annualizer.annualized_invoice_amount).to eq(@annualized_invoice_amount)
        expect(annualizer.annualized_employer_contribution).to be_within(0.01).of(2138.1)
        expect(annualizer.annualized_employee_contribution).to be_within(0.01).of(2138.1)
        expect(annualizer.annualized_diff).to eq(0)
      end

      it 'should return 115ish for 5 pay checks'
    end

    context 'bi-weekly' do
      it 'should return 92ish for 2 paychecks'

      it 'should return 138ish for 3 paychecks'
    end
  end
end