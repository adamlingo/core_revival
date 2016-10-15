require 'rails_helper'

describe EmployeesController, type: :controller do
    

    it "should create a related user" do
        
        expect{
          post :create, email: 'email@mail.com', company_id: 1, employee: true
        }.to change(User,:count).by(1)
        
    end
    
    
    it "should have the same email as the user"
    
    it "should send email notification"

    it "should update name of user"
    
    it "should udpate email of user"
    
    it "should display a new employee created message"
    
    it "should create a zendesk ticket for new"
    
    it "should display a employee updated message"
    
    it "should create a zendesk ticket for update"
    
    
end