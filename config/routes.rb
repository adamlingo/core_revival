Rails.application.routes.draw do
  
  # Devise login is home page based on pages#home before_filter
  devise_scope :user do
  end

  # Root to pages/home (requires login)
  root 'pages#home'
  # get  'home' => 'pages#home'
  get  'companies_static' => 'pages#companies_static'

  # Devise routes with ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #                      new_admin_user_session GET        /admin/login(.:format)                                               active_admin/devise/sessions#new
  #                          admin_user_session POST       /admin/login(.:format)                                               active_admin/devise/sessions#create
  #                  destroy_admin_user_session DELETE|GET /admin/logout(.:format)                                              active_admin/devise/sessions#destroy
  #                         admin_user_password POST       /admin/password(.:format)                                            active_admin/devise/passwords#create
  #                     new_admin_user_password GET        /admin/password/new(.:format)                                        active_admin/devise/passwords#new
  #                    edit_admin_user_password GET        /admin/password/edit(.:format)                                       active_admin/devise/passwords#edit
  #                                             PATCH      /admin/password(.:format)                                            active_admin/devise/passwords#update
  #                                             PUT        /admin/password(.:format)                                            active_admin/devise/passwords#update
  #                                  admin_root GET        /admin(.:format)                                                     admin/dashboard#index
  #              batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)                            admin/admin_users#batch_action
  #                           admin_admin_users GET        /admin/admin_users(.:format)                                         admin/admin_users#index
  #                                             POST       /admin/admin_users(.:format)                                         admin/admin_users#create
  #                        new_admin_admin_user GET        /admin/admin_users/new(.:format)                                     admin/admin_users#new
  #                       edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)                                admin/admin_users#edit
  #                            admin_admin_user GET        /admin/admin_users/:id(.:format)                                     admin/admin_users#show
  #                                             PATCH      /admin/admin_users/:id(.:format)                                     admin/admin_users#update
  #                                             PUT        /admin/admin_users/:id(.:format)                                     admin/admin_users#update
  #                                             DELETE     /admin/admin_users/:id(.:format)                                     admin/admin_users#destroy
  # batch_action_admin_employee_benefit_details POST       /admin/employees/:employee_id/benefit_details/batch_action(.:format) admin/benefit_details#batch_action
  #              admin_employee_benefit_details GET        /admin/employees/:employee_id/benefit_details(.:format)              admin/benefit_details#index
  #                                             POST       /admin/employees/:employee_id/benefit_details(.:format)              admin/benefit_details#create
  #           new_admin_employee_benefit_detail GET        /admin/employees/:employee_id/benefit_details/new(.:format)          admin/benefit_details#new
  #          edit_admin_employee_benefit_detail GET        /admin/employees/:employee_id/benefit_details/:id/edit(.:format)     admin/benefit_details#edit
  #               admin_employee_benefit_detail GET        /admin/employees/:employee_id/benefit_details/:id(.:format)          admin/benefit_details#show
  #                                             PATCH      /admin/employees/:employee_id/benefit_details/:id(.:format)          admin/benefit_details#update
  #                                             PUT        /admin/employees/:employee_id/benefit_details/:id(.:format)          admin/benefit_details#update
  #                                             DELETE     /admin/employees/:employee_id/benefit_details/:id(.:format)          admin/benefit_details#destroy
  # batch_action_admin_company_benefit_profiles POST       /admin/companies/:company_id/benefit_profiles/batch_action(.:format) admin/benefit_profiles#batch_action
  #              admin_company_benefit_profiles GET        /admin/companies/:company_id/benefit_profiles(.:format)              admin/benefit_profiles#index
  #                                             POST       /admin/companies/:company_id/benefit_profiles(.:format)              admin/benefit_profiles#create
  #           new_admin_company_benefit_profile GET        /admin/companies/:company_id/benefit_profiles/new(.:format)          admin/benefit_profiles#new
  #          edit_admin_company_benefit_profile GET        /admin/companies/:company_id/benefit_profiles/:id/edit(.:format)     admin/benefit_profiles#edit
  #               admin_company_benefit_profile GET        /admin/companies/:company_id/benefit_profiles/:id(.:format)          admin/benefit_profiles#show
  #                                             PATCH      /admin/companies/:company_id/benefit_profiles/:id(.:format)          admin/benefit_profiles#update
  #                                             PUT        /admin/companies/:company_id/benefit_profiles/:id(.:format)          admin/benefit_profiles#update
  #                                             DELETE     /admin/companies/:company_id/benefit_profiles/:id(.:format)          admin/benefit_profiles#destroy
  #                batch_action_admin_companies POST       /admin/companies/batch_action(.:format)                              admin/companies#batch_action
  #                             admin_companies GET        /admin/companies(.:format)                                           admin/companies#index
  #                                             POST       /admin/companies(.:format)                                           admin/companies#create
  #                           new_admin_company GET        /admin/companies/new(.:format)                                       admin/companies#new
  #                          edit_admin_company GET        /admin/companies/:id/edit(.:format)                                  admin/companies#edit
  #                               admin_company GET        /admin/companies/:id(.:format)                                       admin/companies#show
  #                                             PATCH      /admin/companies/:id(.:format)                                       admin/companies#update
  #                                             PUT        /admin/companies/:id(.:format)                                       admin/companies#update
  #                                             DELETE     /admin/companies/:id(.:format)                                       admin/companies#destroy
  #                             admin_dashboard GET        /admin/dashboard(.:format)                                           admin/dashboard#index
  #        batch_action_admin_company_employees POST       /admin/companies/:company_id/employees/batch_action(.:format)        admin/employees#batch_action
  #                     admin_company_employees GET        /admin/companies/:company_id/employees(.:format)                     admin/employees#index
  #                                             POST       /admin/companies/:company_id/employees(.:format)                     admin/employees#create
  #                  new_admin_company_employee GET        /admin/companies/:company_id/employees/new(.:format)                 admin/employees#new
  #                 edit_admin_company_employee GET        /admin/companies/:company_id/employees/:id/edit(.:format)            admin/employees#edit
  #                      admin_company_employee GET        /admin/companies/:company_id/employees/:id(.:format)                 admin/employees#show
  #                                             PATCH      /admin/companies/:company_id/employees/:id(.:format)                 admin/employees#update
  #                                             PUT        /admin/companies/:company_id/employees/:id(.:format)                 admin/employees#update
  #                                             DELETE     /admin/companies/:company_id/employees/:id(.:format)                 admin/employees#destroy
  #                    batch_action_admin_users POST       /admin/users/batch_action(.:format)                                  admin/users#batch_action
  #                                 admin_users GET        /admin/users(.:format)                                               admin/users#index
  #                                             POST       /admin/users(.:format)                                               admin/users#create
  #                              new_admin_user GET        /admin/users/new(.:format)                                           admin/users#new
  #                             edit_admin_user GET        /admin/users/:id/edit(.:format)                                      admin/users#edit
  #                                  admin_user GET        /admin/users/:id(.:format)                                           admin/users#show
  #                                             PATCH      /admin/users/:id(.:format)                                           admin/users#update
  #                                             PUT        /admin/users/:id(.:format)                                           admin/users#update
  #                                             DELETE     /admin/users/:id(.:format)                                           admin/users#destroy
  #                              admin_comments GET        /admin/comments(.:format)                                            admin/comments#index
  #                                             POST       /admin/comments(.:format)                                            admin/comments#create
  #                               admin_comment GET        /admin/comments/:id(.:format)                                        admin/comments#show
  #                                             DELETE     /admin/comments/:id(.:format)                                        admin/comments#destroy

  # Devise user routes
  devise_for :users
  # All included routes for Devise (rake routes):
  #      new_user_session GET    /users/sign_in(.:format)               devise/sessions#new
  #          user_session POST   /users/sign_in(.:format)               devise/sessions#create
  #  destroy_user_session DELETE /users/sign_out(.:format)              devise/sessions#destroy
  #         user_password POST   /users/password(.:format)              devise/passwords#create
  #     new_user_password GET    /users/password/new(.:format)          devise/passwords#new
  #    edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
  #                       PATCH  /users/password(.:format)              devise/passwords#update
  #                       PUT    /users/password(.:format)              devise/passwords#update
  # cancel_user_registration GET    /users/cancel(.:format)             devise/registrations#cancel
  #     user_registration POST   /users(.:format)                       devise/registrations#create
  # new_user_registration GET    /users/sign_up(.:format)               devise/registrations#new
  #edit_user_registration GET    /users/edit(.:format)                  devise/registrations#edit
  #                       PATCH  /users(.:format)                       devise/registrations#update
  #                       PUT    /users(.:format)                       devise/registrations#update
  #                       DELETE /users(.:format)                       devise/registrations#destroy

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

   # default route syntax at bottom instead of get... will match if all other routes fail
  match ':controller(/:action(/:id(.:format)))', :via => :get
end
