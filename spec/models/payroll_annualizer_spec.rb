require 'rails_helper'

describe PayrollAnnualizer, type: :model do

  context 'monthly' do
    it 'should return 100' do
      annualizer = PayrollAnnualizer.new(100.00, 1, 'monthly')

      actual = annualizer.annualize
      expect(actual).to eq(100.00)
    end
  end

  context 'semi-monthly' do
    it 'should return 100ish' do
      annualizer = PayrollAnnualizer.new(100.00, 2, 'semi-monthly')

      actual = annualizer.annualize
      expect(actual).to eq(100.00)
    end
  end

  context 'weekly' do
    it 'should return 92ish for 4 pay checks' do
      annualizer = PayrollAnnualizer.new(100.00, 4, 'weekly')

      actual = annualizer.annualize
      expect(actual).to eq(92)
    end

    it 'should return 115ish for 5 pay checks' do
      annualizer = PayrollAnnualizer.new(100.00, 5, 'weekly')

      actual = annualizer.annualize
      expect(actual).to eq(115)
    end
  end

  context 'bi-weekly' do
    it 'should return 92ish for 2 paychecks' do
      annualizer = PayrollAnnualizer.new(100.00, 2, 'bi-weekly')

      actual = annualizer.annualize
      expect(actual).to eq(92)
    end

    it 'should return 138ish for 3 paychecks' do
      annualizer = PayrollAnnualizer.new(100.00, 3, 'bi-weekly')

      actual = annualizer.annualize
      expect(actual).to eq(138)
    end
  end
end