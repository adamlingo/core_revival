require 'rails_helper'

RSpec.describe FoldersController, type: :controller do 
    fixtures :folders, :employees, :companies, :users

    context 'authenticated' do 
        before(:each) do
            admin_user = users(:admin)
            sign_in(admin_user)
        end
        
        it "should should save a document" 
            
            # post :add_doc
            
 
        it "should create a new folder" do
            
            folder_payload = {
            company_id: 1,
            title: "New Folder",
            description: "This is a test folder"
            }
            
            post :create, folder_payload
            
            expect(flash[:info] = "Document added to folder").to_be_present
        end
        
        it "should delete a folder" 
            
            # post :destory
        
        
        it "should update a folder" 
            
            # post :update
        
        
        it "should delete a document" 
            
            # post :delete_doc
            
        
        
      
    end
end
