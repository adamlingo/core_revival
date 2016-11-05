require 'rails_helper'

describe Salary, :type => :model do
    
    it "is invalid when saved" do
        salary = Salary.new
        expect(salary.valid?).to eq(false)
    end
        
    
    it "is valid when saved" do
        
         salary = Salary.new(employee_id: 1, start_date: '2016-10-31', pay_type: 'test', rate: 40)
         
         expect(salary.valid?).to be(true)
    end
    
    it "has a start_date" do
    
        salary = Salary.new(employee_id: 1, pay_type: 'test', rate: 40)
         
        expect(salary.valid?).to be(false)
        
    end
    
    it "has a rate" do
        
        salary = Salary.new(employee_id: 1, start_date: '2016-10-31', pay_type: 'test')
         
        expect(salary.valid?).to be(false)
        
    end
    
    it "has a pay_type" do
                 
        salary = Salary.new(employee_id: 1, start_date: '2016-10-31', rate: 40)
        
        expect(salary.valid?).to be(false)
    end
    
end


# describe Salary, :type => :model do
#     it "is invalid when saved" do
#         salary = Salary.new
#         expect(salary.valid?).to eq(false)
#       # expect(salary.errors[:email]).to eq(['can\'t be blank'])
#       # expect(salary.errors[:password]).to eq(['can\'t be blank'])

#     end
    
    
#     it "should be valid" do
#         salary = Salary.new   
#         salary.employee_id = 25    
#         salary.start_date = '2013-10-31'
#         salary.rate = 40000
#         salary.pay_type = 'test'
        

#         expect(salary).to eq(true)
#     end
    
# end