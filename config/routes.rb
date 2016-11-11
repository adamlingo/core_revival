Rails.application.routes.draw do
  # Root to pages/home (requires login)
  root 'pages#home'
  get  '/home', to: "pages#home", as: "home"
  get  'users' => 'users#index'

  # Devise routes with ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise user routes
  devise_for :users, controllers: { sessions: "users/sessions",
                                    passwords: "users/passwords"}
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  # make Employees editable records that belong to companies by id
  resources :companies do
    resources :employee_benefits
    resources :benefit_profiles
    resources :payroll_records 
    resources :employees do
      # EmployeeFolder
      resources :folders, controller: 'employee_folders' do
        delete "delete_doc/:doc_id", to: 'employee_folders#delete_doc', as: 'delete_doc'
        get "new_doc", to: 'employee_folders#new_doc', as: 'new_doc'
        patch "add_doc", to: 'employee_folders#add_doc', as: 'add_doc'
        # company_employee_folder_delete_doc DELETE     /companies/:company_id/employees/:employee_id/folders/:folder_id/delete_doc/:doc_id(.:format) employee_folders#delete_doc
        #    company_employee_folder_new_doc GET        /companies/:company_id/employees/:employee_id/folders/:folder_id/new_doc(.:format)            employee_folders#new_doc
        #    company_employee_folder_add_doc PATCH      /companies/:company_id/employees/:employee_id/folders/:folder_id/add_doc(.:format)            employee_folders#add_doc
        #           company_employee_folders GET        /companies/:company_id/employees/:employee_id/folders(.:format)                               employee_folders#index
        #                                    POST       /companies/:company_id/employees/:employee_id/folders(.:format)                               employee_folders#create
        #        new_company_employee_folder GET        /companies/:company_id/employees/:employee_id/folders/new(.:format)                           employee_folders#new
        #       edit_company_employee_folder GET        /companies/:company_id/employees/:employee_id/folders/:id/edit(.:format)                      employee_folders#edit
        #            company_employee_folder GET        /companies/:company_id/employees/:employee_id/folders/:id(.:format)                           employee_folders#show
        #                                    PATCH      /companies/:company_id/employees/:employee_id/folders/:id(.:format)                           employee_folders#update
        #                                    PUT        /companies/:company_id/employees/:employee_id/folders/:id(.:format)                           employee_folders#update
        #                                    DELETE     /companies/:company_id/employees/:employee_id/folders/:id(.:format)                           employee_folders#destroy
      end
    end
    
    # Folder/CompanyFolder routes
    resources :folders do
      delete "delete_doc/:doc_id", to: 'folders#delete_doc', as: 'delete_doc'
      get "new_doc", to: 'folders#new_doc', as: 'new_doc'
      patch "add_doc", to: 'folders#add_doc', as: 'add_doc'
      # company_folder_delete_doc DELETE     /companies/:company_id/folders/:folder_id/delete_doc/:doc_id(.:format)             folders#delete_doc
      #    company_folder_add_doc POST       /companies/:company_id/folders/:folder_id/add_doc(.:format)                        folders#add_doc
      #           company_folders GET        /companies/:company_id/folders(.:format)                                           folders#index
      #                           POST       /companies/:company_id/folders(.:format)                                           folders#create
      #        new_company_folder GET        /companies/:company_id/folders/new(.:format)                                       folders#new
      #       edit_company_folder GET        /companies/:company_id/folders/:id/edit(.:format)                                  folders#edit
      #            company_folder GET        /companies/:company_id/folders/:id(.:format)                                       folders#show
      #                           PATCH      /companies/:company_id/folders/:id(.:format)                                       folders#update
      #                           PUT        /companies/:company_id/folders/:id(.:format)                                       folders#update
      #                           DELETE     /companies/:company_id/folders/:id(.:format)                                       folders#destroy                      
    end
  end
  # this creates resources to have EEs and BenefitProfiles belong to companies, and are listed here:
  #                         company_employees GET        /companies/:company_id/employees(.:format)                           employees#index
  #                                           POST       /companies/:company_id/employees(.:format)                           employees#create
  #                      new_company_employee GET        /companies/:company_id/employees/new(.:format)                       employees#new
  #                     edit_company_employee GET        /companies/:company_id/employees/:id/edit(.:format)                  employees#edit
  #                          company_employee GET        /companies/:company_id/employees/:id(.:format)                       employees#show
  #                                           PATCH      /companies/:company_id/employees/:id(.:format)                       employees#update
  #                                           PUT        /companies/:company_id/employees/:id(.:format)                       employees#update
  #                                           DELETE     /companies/:company_id/employees/:id(.:format)                       employees#destroy
  #                  company_benefit_profiles GET        /companies/:company_id/benefit_profiles(.:format)                    benefit_profiles#index
  #                                           POST       /companies/:company_id/benefit_profiles(.:format)                    benefit_profiles#create
  #               new_company_benefit_profile GET        /companies/:company_id/benefit_profiles/new(.:format)                benefit_profiles#new
  #              edit_company_benefit_profile GET        /companies/:company_id/benefit_profiles/:id/edit(.:format)           benefit_profiles#edit
  #                   company_benefit_profile GET        /companies/:company_id/benefit_profiles/:id(.:format)                benefit_profiles#show
  #                                           PATCH      /companies/:company_id/benefit_profiles/:id(.:format)                benefit_profiles#update
  #                                           PUT        /companies/:company_id/benefit_profiles/:id(.:format)                benefit_profiles#update
  #                                           DELETE     /companies/:company_id/benefit_profiles/:id(.:format)                benefit_profiles#destroy
  #                                 companies GET        /companies(.:format)                                                 companies#index
  #                                           POST       /companies(.:format)                                                 companies#create
  #                               new_company GET        /companies/new(.:format)                                             companies#new
  #                              edit_company GET        /companies/:id/edit(.:format)                                        companies#edit
  #                                   company GET        /companies/:id(.:format)                                             companies#show
  #                                           PATCH      /companies/:id(.:format)                                             companies#update
  #                                           PUT        /companies/:id(.:format)                                             companies#update
  #                                           DELETE     /companies/:id(.:format)                                             companies#destroy

  resources :health_invoices do
    collection { post :import }
  end
  # routes for health invoices csv import:
  #                    import_health_invoices POST       /health_invoices/import(.:format)                                    health_invoices#import
  #                           health_invoices GET        /health_invoices(.:format)                                           health_invoices#index
  #                                           POST       /health_invoices(.:format)                                           health_invoices#create
  #                        new_health_invoice GET        /health_invoices/new(.:format)                                       health_invoices#new
  #                       edit_health_invoice GET        /health_invoices/:id/edit(.:format)                                  health_invoices#edit
  #                            health_invoice GET        /health_invoices/:id(.:format)                                       health_invoices#show
  #                                           PATCH      /health_invoices/:id(.:format)                                       health_invoices#update
  #                                           PUT        /health_invoices/:id(.:format)                                       health_invoices#update
  #                                           DELETE     /health_invoices/:id(.:format)                                       health_invoices#destroy

  resources :payroll_deductions do
    collection { post :import }
  end
  # routes for payroll deductions csv import:
  #                 import_payroll_deductions POST       /payroll_deductions/import(.:format)                                 payroll_deductions#import
  #                        payroll_deductions GET        /payroll_deductions(.:format)                                        payroll_deductions#index
  #                                           POST       /payroll_deductions(.:format)                                        payroll_deductions#create
  #                     new_payroll_deduction GET        /payroll_deductions/new(.:format)                                    payroll_deductions#new
  #                    edit_payroll_deduction GET        /payroll_deductions/:id/edit(.:format)                               payroll_deductions#edit
  #                         payroll_deduction GET        /payroll_deductions/:id(.:format)                                    payroll_deductions#show
  #                                           PATCH      /payroll_deductions/:id(.:format)                                    payroll_deductions#update
  #                                           PUT        /payroll_deductions/:id(.:format)                                    payroll_deductions#update
  #                                           DELETE     /payroll_deductions/:id(.:format)                                    payroll_deductions#destroy


  resources :reconciliations do 
    collection do
      post :calculate
    end
  end

  
   # default route syntax at bottom instead of get... will match if all other routes fail
  match ':controller(/:action(/:id(.:format)))', :via => :get
end
