Rails.application.routes.draw do
  
  # Devise login is root of applicaiton
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # Roots for static pages (get)
  get  'home' => 'pages#home'
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
  # batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format) admin/admin_users#batch_action
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
  #             companies GET    /companies(.:format)                                companies#index
  #                       POST   /companies(.:format)                                companies#create
  #           new_company GET    /companies/new(.:format)                            companies#new
  #          edit_company GET    /companies/:id/edit(.:format)                       companies#edit
  #               company GET    /companies/:id(.:format)                            companies#show
  #                       PATCH  /companies/:id(.:format)                            companies#update
  #                       PUT    /companies/:id(.:format)                            companies#update
  #                       DELETE /companies/:id(.:format)                            companies#destroy
  #                       GET    /:controller(/:action(/:id(.:format)))              :controller#:action



  # DEFAULT DOCUMENTATION OF ROUTE-HANDLING WITH REGULAR/NESTED RESOURCES
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

   # default route syntax at bottom instead of get... will match if all other routes fail
  match ':controller(/:action(/:id(.:format)))', :via => :get
end
