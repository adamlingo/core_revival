require 'rails_helper'

describe Employee, type: :model do
    # controller tests?
    # it "should create a comparable user"
    
    # it "should have the same email as the user"
    
    # it "should update the user information"
    
    it "should have a unique email" do
        e1 = Employee.new(email: 'unique@email.com', company_id: 1)
        e2 = Employee.new(email: 'unique@email.com', company_id: 1)
        e1.save!
        
        expect do
            e2.save!
        end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Email has already been taken')
    end
    
    it "should have a company id" do
        e = Employee.new(email: 'unique@email.com')
        ee = Employee.new(email: 'user@email.com', company_id: 1)
        expect(e.valid?).to eq(false)
        expect(ee.valid?).to eq(true)
    end
    
    it "should be valid" do
        e = Employee.new(email: 'test@admin.com', company_id: 1)
        expect(e.valid?).to eq(true)
    end
    
    it "should save ssn encrypted" do
        e = Employee.new(ssn: '123-45-6789', email: 'unique@email.com', company_id: 1)
        ssn = e.ssn
        encrypted_ssn = e.encrypted_ssn
        iv = e.encrypted_ssn_iv
        expect(e.valid?).to eq(true)
        expect(ssn).not_to eq(encrypted_ssn)
        expect(ssn).to eq('123-45-6789')
        expect(iv).to be_truthy
    end
    

end