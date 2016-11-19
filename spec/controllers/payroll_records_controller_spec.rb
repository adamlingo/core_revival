require 'rails_helper'

RSpec.describe PayrollRecordsController, type: :controller do
    fixtures :users, :companies, :payroll_records, :employees
    
    # context 'not authenticated' do
    #     it 'blocks unauthenticated access' do
    #         sign_in nil
            
    #         get :index, { company_id: 1}
            
    #         expect(response).to have_http_status(:found)
    #         expect(response).to redirect_to(new_user_session_path)
    #     end
    # end
    
    
    # context 'authenticated' do
    #     before(:each) do
    #         allow(ZendeskService).to receive(:create_ticket).and_return(43)
    #         admin_user = users(:admin)
    #         sign_in(admin_user)
    #     end
    
        
        # it "should display all of the related employees of a company" do
        
        #     company = companies(:demo)
 
        #     get :index, company
        #     employee_count = Employee.where(company_id: company.id).count
            
        #     expect(employee_count).to eq(@employees.count)
        
        # end
        
        it "should save a record from form" do
            
            before_count = PayrollRecord.count
            
            form_payload = {
                company_id: 1,
                employee_id: 1,
                reg_hours: 40
            }
            
            post :create, form_payload
            
            after_count = PayrollRecord.count
            
            expect(response).to have_http_status(:found)
            expect(after_count).not_to eq(before_count)
            expect(response).to redirect_to(company_payroll_records_path)
            expect(flash[:success]).to be_present
        end

        # it "should display a success message"
        
        it "should notify slack when saved"
        
        
        # not sure how to do this one!
        
        
        it "should create a csv file when exported"
        
        payload = {
            company_id: 1,
            export_id: 12345
        }
        post :export, payload
        expect()  # file name?
        
        it "should not allow an employee user to create a record"
    end
# end