require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  fixtures :companies, :users, :employees

  context 'not authenticated' do
    it "blocks unauthenticated access" do
      sign_in nil

      get :index, { company_id: 1 }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'authenticated' do
    before(:each) do
      allow(ZendeskService).to receive(:create_ticket).and_return(42)

      admin_user = users(:admin)
      sign_in(admin_user)
    end
    
    it "should display a new employee created message" do
        
      employee_payload = {
      company_id: 1,
      employee: {
      first_name: 'Ima',
      last_name: 'New Employee',
      email: 'totally-fake@core-redux.com'
        }
      } 

      post :create, employee_payload
      
      expect(flash[:success]).to be_present
    
    end
    
    it "should save ssn as encrypted" do
      
            employee_payload = {
      company_id: 1,
      employee: {
      first_name: 'Ima',
      last_name: 'New Employee',
      email: 'totally-fake@core-redux.com',
      ssn: '123-45-6789'
        }
      } 

      post :create, employee_payload
      
      after_employee = Employee.find_by(first_name: 'Ima', last_name: 'New Employee')
      
      expect(after_employee.ssn).to eq('123-45-6789')
      expect(after_employee.encrypted_ssn).not_to eq(after_employee.ssn)
      
 
    end

    it "should create a related user" do
      before_employee = Employee.find_by(first_name: 'Ima', last_name: 'New Employee')
      expect(before_employee).to be(nil)

      employee_payload = {
        company_id: 1,
        employee: {
        first_name: 'Ima',
        last_name: 'New Employee',
        email: 'totally-fake@core-redux.com'
        }
      }

      post :create, employee_payload

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(company_employees_path)

      after_employee = Employee.find_by(first_name: 'Ima', last_name: 'New Employee')
      expect(after_employee).not_to be(nil)

      user = User.find_by(id: after_employee.user_id)
      expect(user).not_to be(nil)
      expect(user.email).to eq(after_employee.email)
    end


    it "should update name and email of user" do
      
      before_employee = Employee.create!(company_id: 1, last_name: "Robin", first_name: "Christopher", email: 'pooh@bridge.com')
      
      puts before_employee.id
      
      employee_payload = {
        company_id: before_employee.company_id,
        id: before_employee.id,
        employee: {
          first_name: 'Ima',
          last_name: 'New Employee',
          email: 'totally-fake@core-redux.com'
        }
      }

      post :update, employee_payload

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(company_employees_path)
      expect(flash[:success]).to be_present

      after_employee = Employee.find_by(id: before_employee.id)
      expect(after_employee).not_to be(nil)

      expect(after_employee.first_name).to eq("Ima")
      expect(after_employee.last_name).to eq("New Employee")
      expect(after_employee.email).to eq("totally-fake@core-redux.com")
      
    end
    
  context 'authenticated employee' do
    before(:each) do
      allow(ZendeskService).to receive(:create_ticket).and_return(42)

      employee_user = users(:employee)
      sign_in(employee_user)
    end
    
    it "should not allow an employee user to create a new user" do
      before_count = Employee.count

      employee_payload = {
          company_id: 1,
          employee: {
          first_name: 'Ima',
          last_name: 'New Employee',
          email: 'totally-fake@core-redux.com'
          }
        }
  
      post :create, employee_payload
      
      after_count = Employee.count
      expect(after_count).to eq(before_count)
  
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
  
    end


  end
  
      

    
    
    # it "should send email notification"

    # it "should create a zendesk ticket for new"

    # it "should create a zendesk ticket for update"
  end
end