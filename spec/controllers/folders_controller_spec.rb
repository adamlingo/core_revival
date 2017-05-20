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

        context 'add_doc' do
            before(:each) do
                @doc_path = "test.pdf".freeze
            end

            it "should raise an error if no document uploaded" do
                folder_payload = {
                    folder: {
                        title: "New Folder",
                        description: "This is a test folder"
                    },
                    company_id: 1
                }
                
                post :create, folder_payload
                
                new_folder = Folder.find_by(title: "New Folder")

                new_doc = {
                    folder_id: new_folder.id,
                    company_id: 1,
                    folder: {
                        description: 'all my documents',
                        documents_files: []
                    }
                }
                
                post :add_doc, new_doc

                expect(flash[:info]).not_to be_present
                expect(flash[:error]).to be_present
                expect(flash[:error]).to eq('At least one document is required.')
            end

            it "should raise an error if documents cannot be saved" do
                folder_payload = {
                    folder: {
                        title: "New Folder",
                        description: "This is a test folder"
                    },
                    company_id: 1
                }
                
                post :create, folder_payload
                
                new_folder = Folder.find_by(title: "New Folder")

                new_doc = {
                    folder_id: new_folder.id,
                    company_id: 1,
                    folder: {
                        description: 'all my documents',
                        documents_files: [42]
                    }
                }
                
                post :add_doc, new_doc

                expect(flash[:info]).not_to be_present
                expect(flash[:error]).to be_present
                expect(flash[:error]).to eq('At least one document is required!')
            end

            it "should save documents successfully" do
                folder_payload = {
                    folder: {
                        title: "New Folder",
                        description: "This is a test folder"
                    },
                    company_id: 1
                }
                
                post :create, folder_payload
                
                new_folder = Folder.find_by(title: "New Folder")

                file = fixture_file_upload(@doc_path, 'application/pdf')

                new_doc = {
                    folder_id: new_folder.id,
                    company_id: 1,
                    folder: {
                        description: 'all my documents',
                        documents_files: [file]
                    }
                }
                
                post :add_doc, new_doc

                expect(flash[:info]).not_to be_present
                expect(flash[:error]).to be_present
                expect(flash[:error]).to eq('At least one document is required!')
            end

        end

        it "should delete a document" do
            # folder = Folder.new(title: 'my folder')
            # folder.save!

            # doc = Document.new(folder_id: folder.id, )
            # doc.save!

            # delete :delete_doc, 

        end
    end
end
