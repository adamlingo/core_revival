require 'rails_helper'

describe InvoiceConverter, type: :model do

  context 'monthly' do
    it 'should return 100' do
      invoice_converter = InvoiceConverter.new(100.00, 1, 'monthly')

      actual = invoice_converter.to_monthly_expected_amount
      expect(actual).to eq(100.00)
      expect(actual).to be_within(0.01).of(100.00)
    end
  end

  context 'semi-monthly' do
    it 'should return 100ish' do
      invoice_converter = InvoiceConverter.new(100.00, 2, 'semi-monthly')

      actual = invoice_converter.to_monthly_expected_amount
      expect(actual).to eq(100.00)
      expect(actual).to be_within(0.01).of(100.00)
    end
  end

  context 'weekly' do
    it 'should return 92ish for 4 pay checks' do
      invoice_converter = InvoiceConverter.new(100.00, 4, 'weekly')

      actual = invoice_converter.to_monthly_expected_amount
      expect(actual).to be_within(0.01).of(92.31)
    end

    it 'should return 115ish for 5 pay checks' do
      invoice_converter = InvoiceConverter.new(100.00, 5, 'weekly')

      actual = invoice_converter.to_monthly_expected_amount
      expect(actual).to be_within(0.01).of(115.38)
    end
  end

  context 'bi-weekly' do
    it 'should return 92ish for 2 paychecks' do
      invoice_converter = InvoiceConverter.new(100.00, 2, 'bi-weekly')

      actual = invoice_converter.to_monthly_expected_amount
      expect(actual).to be_within(0.01).of(92.31)
    end

    it 'should return 138ish for 3 paychecks' do
      invoice_converter = InvoiceConverter.new(100.00, 3, 'bi-weekly')

      actual = invoice_converter.to_monthly_expected_amount
      expect(actual).to be_within(0.01).of(138.46)
    end
  end
end