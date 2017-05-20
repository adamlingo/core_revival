require 'rails_helper'

RSpec.describe SalariesController, type: :controller do
    # fixtures:
    
    context 'not authenticated' do
        it "blocks unauthenticated access" do
          sign_in nil

          employee = Employee.first!
          company = employee.company

          get :index, { 
            company_id: company.id,
            employee_id: employee.id
          }
    
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
    
    # it "should display a salary updated message"
    
    # it "should allow a manager user to create a new salary"
    
  
    end
    
  # it "should not allow a non-manager user to create a new salary"
    
end