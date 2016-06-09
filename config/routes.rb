Rails.application.routes.draw do
  
  # Devise login is home page based on pages#home before_filter
  devise_scope :user do
  end

  # Roots for static pages (get)
  root 'pages#home'
  # get  'home' => 'pages#home'
  get  'companies_static' => 'pages#companies_static'

  # Devise routes with ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #      new_admin_user_session GET        /admin/login(.:format)                    active_admin/devise/sessions#new
  #          admin_user_session POST       /admin/login(.:format)                    active_admin/devise/sessions#create
  #  destroy_admin_user_session DELETE|GET /admin/logout(.:format)                   active_admin/devise/sessions#destroy
  #         admin_user_password POST       /admin/password(.:format)                 active_admin/devise/passwords#create
  #     new_admin_user_password GET        /admin/password/new(.:format)             active_admin/devise/passwords#new
  #    edit_admin_user_password GET        /admin/password/edit(.:format)            active_admin/devise/passwords#edit
  #                             PATCH      /admin/password(.:format)                 active_admin/devise/passwords#update
  #                             PUT        /admin/password(.:format)                 active_admin/devise/passwords#update
  #                  admin_root GET        /admin(.:format)                          admin/dashboard#index
  # batch_action_admin_admin_users POST    /admin/admin_users/batch_action(.:format) admin/admin_users#batch_action
  #           admin_admin_users GET        /admin/admin_users(.:format)              admin/admin_users#index
  #                             POST       /admin/admin_users(.:format)              admin/admin_users#create
  #        new_admin_admin_user GET        /admin/admin_users/new(.:format)          admin/admin_users#new
  #       edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)     admin/admin_users#edit
  #            admin_admin_user GET        /admin/admin_users/:id(.:format)          admin/admin_users#show
  #                             PATCH      /admin/admin_users/:id(.:format)          admin/admin_users#update
  #                             PUT        /admin/admin_users/:id(.:format)          admin/admin_users#update
  #                             DELETE     /admin/admin_users/:id(.:format)          admin/admin_users#destroy
  #             admin_dashboard GET        /admin/dashboard(.:format)                admin/dashboard#index
  #              admin_comments GET        /admin/comments(.:format)                 admin/comments#index
  #                             POST       /admin/comments(.:format)                 admin/comments#create
  #               admin_comment GET        /admin/comments/:id(.:format)             admin/comments#show
  #                             DELETE     /admin/comments/:id(.:format)             admin/comments#destroy

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
  # this creates resources to have EEs belong to companies, and are listed here:
  #     company_employees GET    /companies/:company_id/employees(.:format)          employees#index
  #                       POST   /companies/:company_id/employees(.:format)          employees#create
  #  new_company_employee GET    /companies/:company_id/employees/new(.:format)      employees#new
  # edit_company_employee GET    /companies/:company_id/employees/:id/edit(.:format) employees#edit
  #      company_employee GET    /companies/:company_id/employees/:id(.:format)      employees#show
  #                       PATCH  /companies/:company_id/employees/:id(.:format)      employees#update
  #                       PUT    /companies/:company_id/employees/:id(.:format)      employees#update
  #                       DELETE /companies/:company_id/employees/:id(.:format)      employees#destroy
  #
  #company_benefit_profiles     GET        /companies/:company_id/benefit_profiles(.:format)          benefit_profiles#index
  #                             POST       /companies/:company_id/benefit_profiles(.:format)          benefit_profiles#create
  # new_company_benefit_profile GET        /companies/:company_id/benefit_profiles/new(.:format)      benefit_profiles#new
  #edit_company_benefit_profile GET        /companies/:company_id/benefit_profiles/:id/edit(.:format) benefit_profiles#edit
  #     company_benefit_profile GET        /companies/:company_id/benefit_profiles/:id(.:format)      benefit_profiles#show
  #                             PATCH      /companies/:company_id/benefit_profiles/:id(.:format)      benefit_profiles#update
  #                             PUT        /companies/:company_id/benefit_profiles/:id(.:format)      benefit_profiles#update
  #                             DELETE     /companies/:company_id/benefit_profiles/:id(.:format)      benefit_profiles#destroy

  #             companies GET    /companies(.:format)                                companies#index
  #                       POST   /companies(.:format)                                companies#create
  #           new_company GET    /companies/new(.:format)                            companies#new
  #          edit_company GET    /companies/:id/edit(.:format)                       companies#edit
  #               company GET    /companies/:id(.:format)                            companies#show
  #                       PATCH  /companies/:id(.:format)                            companies#update
  #                       PUT    /companies/:id(.:format)                            companies#update
  #                       DELETE /companies/:id(.:format)                            companies#destroy
  #                       GET    /:controller(/:action(/:id(.:format)))              :controller#:action



   # default route syntax at bottom instead of get... will match if all other routes fail
  match ':controller(/:action(/:id(.:format)))', :via => :get
end
