require 'rails_helper'

RSpec.describe PayrollRecordsController, type: :controller do
    
    
    context 'not authenticated' do
        it 'blocks unauthenticated access' do
            sign_in nil
            
            get :index, { company_id: 1}
            
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_user_session_path)
        end
    end
    
    
    context 'authenticated' do
        before(:each) do
            allow(ZendeskService).to receive(:create_ticket).and_return(43)
            admin_user = users(:admin)
            sign_in(admin_user)
        end
    
        
        it "should display all of the related employees of a company"
        
        it "should save a record from form"
        
        it "should display a success message"
        
        it "should notify slack when saved"
        
        it "should create a csv file when exported"
        
        it "should not allow an employee user to create a record"
    end
end