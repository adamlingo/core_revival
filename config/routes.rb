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

  resources :companies do
    resources :employee_benefits
    resources :benefit_profiles
    resources :payroll_records, only: [:index, :create] 
    get "payroll_records/export", to: 'payroll_records#export', as: 'export'

    
    resources :employees do
      resources :salaries
      resources :employee_benefits
      # EmployeeFolder
      resources :folders, controller: 'employee_folders' do
        delete "delete_doc/:doc_id", to: 'employee_folders#delete_doc', as: 'delete_doc'
        get "new_doc", to: 'employee_folders#new_doc', as: 'new_doc'
        patch "add_doc", to: 'employee_folders#add_doc', as: 'add_doc'
      end
    end
    
    # Folder/CompanyFolder routes
    resources :folders do
      delete "delete_doc/:doc_id", to: 'folders#delete_doc', as: 'delete_doc'
      get "new_doc", to: 'folders#new_doc', as: 'new_doc'
      patch "add_doc", to: 'folders#add_doc', as: 'add_doc'
    end
  end

  resources :health_invoices do
    collection { post :import }
  end

  resources :payroll_deductions do
    collection { post :import }
  end

  resources :reconciliations do 
    collection do
      post :calculate
    end
  end

  
   # default route syntax at bottom instead of get... will match if all other routes fail
  match ':controller(/:action(/:id(.:format)))', :via => :get
end
