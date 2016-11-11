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
    resources :employees do 
    # PayrollRecord
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
