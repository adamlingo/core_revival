require 'rails_helper'

describe PayrollRecord, type: :model do
    
    it "should belong to a company" do
    
    pr = PayrollRecord.new(company_id: 1, employee_id: 2)
    pr2 = PayrollRecord.new(company_id: 1)
    pr3 = PayrollRecord.new(employee_id: 2)
    
    expect(pr.valid?).to eq(true)
    expect(pr2.valid?).to eq(false)
    expect(pr3.valid?).to eq(false)
    end
    
end