require 'rails_helper'

RSpec.describe FoldersController, type: :controller do 
    fixtures :employees, :companies, :users

    context 'authenticated' do 
        before(:each) do
            admin_user = users(:admin)
            sign_in(admin_user)
        end

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

            delete :destroy, {company_id: 1, id: new_folder.id}
            
            after_folder = Folder.find_by(title: "New Folder")
            
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(company_folders_path)
            expect(after_folder).to be(nil)
            
        end
        
        
        it "should update a folder" do
            
            folder_payload = {
                folder: {
                    title: "New Folder",
                    description: "This is a test folder"
                },
                company_id: 1
            }
            
            post :create, folder_payload
            
            new_folder = Folder.find_by(title: "New Folder")
            
            update_folder = {
                folder: {
                    title: "Changed Folder",
                    description: "This is the changed folder"
                },
                company_id: 1,
                id: new_folder.id,
            }
            
            patch :update, update_folder
            
            after_folder = Folder.find_by(title: "Changed Folder")
            
            expect(response).to have_http_status(:found)
            expect(response).to redirect_to(company_folder_path)
            expect(after_folder).not_to be(nil)
            expect(after_folder.title).to eq("Changed Folder")
            expect(after_folder.description).to eq("This is the changed folder")
            
        end
            
        
                
        it "should should save a document" do
            
                        
            folder_payload = {
                folder: {
                    title: "New Folder",
                    description: "This is a test folder"
                },
                company_id: 1
            }
            
            post :create, folder_payload
            
            new_folder = Folder.find_by(title: "New Folder")
            
            doc = "#{Rails.root}/spec/fixtures/test.pdf".freeze
            
            new_doc = {
                folder_id: new_folder.id,
                company_id: 1,
                folder: {
                    description: 'all my documents',
                    documents_files: []
                }
            }
            
            post :add_doc, new_doc
            
        end
 
        it "should delete a document" 
            
            # post :delete_doc
            
        
        
      
    end
end
