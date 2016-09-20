Rails.application.routes.draw do
  
  # Devise login is home page based on pages#home before_filter

  # Root to pages/home (requires login)
  root 'pages#home'
  get  '/home', to: "pages#home", as: "home"
  get  'companies_static' => 'pages#companies_static'
  get  'users' => 'users#index'

  # Devise routes with ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise user routes
  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations"}
  

  # make Employees editable records that belong to companies by id
  resources :companies do
    resources :employees
    resources :benefit_profiles
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
