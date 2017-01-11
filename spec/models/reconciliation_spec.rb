require 'rails_helper'

describe Reconciliation, type: :model do
  fixtures :companies

  it 'should calculate correctly'
  it 'should fail miserably when no health invoices for the input month and year'
  it 'should fail miserably when no payroll deductions for the input month and year'
end