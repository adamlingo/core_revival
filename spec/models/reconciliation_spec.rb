require 'rails_helper'

describe Reconciliation, type: :model do
  fixtures :companies

  # context 'monthly' do
  #   it 'should do the needful' do
  #     reconciliation = Reconciliation.new(@company_id, @month, @year)

  #     actual = reconciliation.calculate
  #     expect(actual).to eq(100.00)
  #     expect(actual).to be_within(0.01).of(100.00)
  #   end
  # end

  # context 'semi-monthly' do
  #   it 'should return 100ish' do
  #     reconciliation = Reconciliation.new(100.00, 2, 'semi-monthly')

  #     actual = reconciliation.calculate
  #     expect(actual).to eq(100.00)
  #     expect(actual).to be_within(0.01).of(100.00)
  #   end
  # end

  context 'weekly' do
    it 'should return 92ish for 4 pay checks' do
      company = companies(:weekly_payroll)
      reconciliation = Reconciliation.new(company.id, 8, 2016)

      actual = reconciliation.calculate
      expect(actual).to be_within(0.01).of(92.31)
    end

    it 'should return 115ish for 5 pay checks' do
      company = companies(:weekly_payroll)
      reconciliation = Reconciliation.new(company.id, 8, 2016)

      actual = reconciliation.calculate
      expect(actual).to be_within(0.01).of(115.38)
    end
  end

  # context 'bi-weekly' do
  #   it 'should return 92ish for 2 paychecks' do
  #     reconciliation = Reconciliation.new(100.00, 2, 'bi-weekly')

  #     actual = reconciliation.calculate
  #     expect(actual).to be_within(0.01).of(92.31)
  #   end

  #   it 'should return 138ish for 3 paychecks' do
  #     reconciliation = Reconciliation.new(100.00, 3, 'bi-weekly')

  #     actual = reconciliation.calculate
  #     expect(actual).to be_within(0.01).of(138.46)
  #   end
  # end
end