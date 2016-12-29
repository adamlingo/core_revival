require 'rails_helper'

RSpec.describe SalariesController, type: :controller do
    # fixtures:
    
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
    
    # it "should display a salary updated message"
    
    # it "should allow a manager user to create a new salary"
    
  
    end
    
  # it "should not allow a non-manager user to create a new salary"
    
end