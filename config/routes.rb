Rails.application.routes.draw do
  
  # home page is root of applicaiton
  root                'pages#home'

  get  'companies' => 'pages#companies'

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
  
  # this creates resources to have EEs belong to companies, and are listed here:
  #     company_employees GET    /companies/:company_id/employees(.:format)          employees#index
  #                       POST   /companies/:company_id/employees(.:format)          employees#create
  #  new_company_employee GET    /companies/:company_id/employees/new(.:format)      employees#new
  # edit_company_employee GET    /companies/:company_id/employees/:id/edit(.:format) employees#edit
  #      company_employee GET    /companies/:company_id/employees/:id(.:format)      employees#show
  #                       PATCH  /companies/:company_id/employees/:id(.:format)      employees#update
  #                       PUT    /companies/:company_id/employees/:id(.:format)      employees#update
  #                       DELETE /companies/:company_id/employees/:id(.:format)      employees#destroy
  #                       GET    /companies(.:format)                                companies#index
  #                       POST   /companies(.:format)                                companies#create
  #           new_company GET    /companies/new(.:format)                            companies#new
  #          edit_company GET    /companies/:id/edit(.:format)                       companies#edit
  #               company GET    /companies/:id(.:format)                            companies#show
  #                       PATCH  /companies/:id(.:format)                            companies#update
  #                       PUT    /companies/:id(.:format)                            companies#update
  #                       DELETE /companies/:id(.:format)                            companies#destroy
  #                       GET    /:controller(/:action(/:id(.:format)))              :controller#:action


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
