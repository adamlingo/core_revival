require 'rails_helper'

RSpec.describe PayrollRecordsController, type: :controller do
    fixtures :users, :companies, :payroll_records, :employees
    
    context 'not authenticated' do
        it 'blocks unauthenticated access' do
            sign_in nil
            
            get :index, { company_id: 1}
            
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(new_user_session_path)
        end
    end

    context 'authenticated manager' do
        before(:each) do
            allow(SlackService).to receive(:notify).and_return(nil)

            manager_user = users(:manager)
            sign_in(manager_user)
        end
    
        it "should save a record from form" do
            company_id = 2
            company = Company.find(company_id)
            expect_diff = company.employees.count
            before_count = PayrollRecord.count
            
            form_payload = {
                company_id: company_id,
                '2-reg_hours': 40,
                '2-ot_hours': 2
            }
            
            post :create, form_payload
            
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(company_payroll_records_path)
            expect(flash[:success]).to eq("Payroll Successfully Submitted")
            after_count = PayrollRecord.count
            after_diff = after_count - before_count
            expect(after_diff).to eq(expect_diff)
            expect(SlackService).to have_received(:notify)
        end

        it "should create many records from a form" do
            company_id = 2
            company = Company.find(company_id)
            expect_diff = company.employees.count
            before_count = PayrollRecord.count
            
            form_payload = {}
            form_payload['company_id'] = company_id
            
            company.employees.each { |employee|
                form_payload["#{employee.id}-reg_hours"] = 35 + employee.id
                form_payload["#{employee.id}-ot_hours"] = employee.id
                form_payload["#{employee.id}-other_pay"] = 5 + employee.id
                form_payload["#{employee.id}-sick_hours"] = 15 + employee.id
                form_payload["#{employee.id}-vacation_hours"] = 20 + employee.id
                form_payload["#{employee.id}-holiday_hours"] = 25 + employee.id
                form_payload["#{employee.id}-memo"] = "my memo - #{employee.id}"
            }

            post :create, form_payload
            
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(company_payroll_records_path)
            expect(flash[:success]).to eq("Payroll Successfully Submitted")
            after_count = PayrollRecord.count
            after_diff = after_count - before_count
            expect(after_diff).to eq(expect_diff)
            expect(SlackService).to have_received(:notify)

            company.employees.each { |employee|
                payroll_record = PayrollRecord.find_by(company_id: company.id, employee_id: employee.id)
                expect(payroll_record.reg_hours).to eq(35.0 + employee.id.to_f)
                expect(payroll_record.ot_hours).to eq(employee.id.to_f)
                expect(payroll_record.other_pay).to eq(5.0 + employee.id.to_f)
                expect(payroll_record.sick_hours).to eq(15.0 + employee.id.to_f)
                expect(payroll_record.vacation_hours).to eq(20.0 + employee.id.to_f)
                expect(payroll_record.holiday_hours).to eq(25.0 + employee.id.to_f)
                expect(payroll_record.memo).to eq("my memo - #{employee.id}")
            }

        end

        it "should create a csv file when exported" do
          export_id = 1234
          employee_id = 2
          company_id = 2

          payroll_record = PayrollRecord.new(employee_id: employee_id,
                                            company_id: company_id,
                                            export_id: export_id,
                                            reg_hours: 41.0,
                                            ot_hours:  5.0,
                                            other_pay: 10.0,
                                            sick_hours: 15.0,
                                            vacation_hours: 20.0,
                                            holiday_hours: 25.0,
                                            memo: "my spec memo - 2")
          payroll_record.save!
          payroll_record.reload

          get :export, {company_id: company_id, export_id: export_id }, format: :csv
          
          expect(response).to have_http_status(:ok)
          expect(response.body).not_to be(nil)
          puts "response.body: #{response.body}"
          expect(response.body).to eq(PayrollRecord.where(company_id: company_id, export_id: export_id).to_csv)
        end
    end


        it "should notify slack when saved"
        
        # mock time and test for specific url
        # mock notify_slack method via :export
        
        
        it "should not allow an employee user to create a record"
    end
# end