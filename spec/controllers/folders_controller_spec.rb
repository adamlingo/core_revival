require 'rails_helper'

RSpec.describe FoldersController, type: :controller do 
    fixtures :employees, :companies, :users

    context 'authenticated' do 
        before(:each) do
            admin_user = users(:admin)
            sign_in(admin_user)
        end
        
        # it "should should save a document" do
            
        #     doc_payload = {
                
        #     }
            
        #     post :add_doc
            
        # end
 
        it "should create a new folder" do
            
            folder_payload = {
                folder: {
                    title: "New Folder",
                    description: "This is a test folder"
                },
                company_id: 1
            }
            
            post :create, folder_payload
            
            new_folder = Folder.find_by(title: "New Folder")

            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(company_folder_path(id: new_folder.id))
            expect(new_folder).not_to be(nil)
            
        end
        
        it "should delete a folder" do
            folder_payload = {
                folder: {
                    title: "New Folder",
                    description: "This is a test folder"
                },
                company_id: 1
            }
            
            post :create, folder_payload
            
            new_folder = Folder.find_by(title: "New Folder")

            post :destory, new_folder.id
            
        end
        
        
        it "should update a folder" 
            
            # post :update
        
        
        it "should delete a document" 
            
            # post :delete_doc
            
        
        
      
    end
end
