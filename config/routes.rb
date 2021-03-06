Rails.application.routes.draw do
  # Root to pages/home (requires login)
  root 'pages#home'
  get  '/home', to: "pages#home", as: "home"
  get  '/invest', to: "pages#invest", as: "invest"
  get  'users' => 'users#index'

  post 'life_insurance_rate_selection/find', to: 'life_insurance_rate_selection#find', as: :find

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
    resources :benefit_profiles
    resources :employee_benefit_selection_types, param: :type, only: [:index, :show, :manager_index] do
      get 'employee_benefit_selection_types', to: 'employee_benefit_selection_types#manager_index', as: :manager_index
      post 'accept', to: 'employee_benefit_selection_types#accept', as: :accept
      post 'decline', to: 'employee_benefit_selection_types#decline', as: :decline
    end
    resources :payroll_records, only: [:index, :create] 
    get "payroll_records/export", to: 'payroll_records#export', as: 'export'

    get 'reconciliations', to: 'reconciliations#index', as: :index
    post 'reconciliations/calculate', to: 'reconciliations#calculate', as: :calculate
    post 'reconciliations/import_health_invoices', to: 'reconciliations#import_health_invoices', as: :import_health_invoices
    post 'reconciliations/import_payroll_deductions', to: 'reconciliations#import_payroll_deductions', as: :import_payroll_deductions

    resources :employees do
      get "invite" , to: 'employees#invite', as: 'invite'
      resources :dependents
      resources :employee_benefit_selections
      resources :rate_selections, only: [:new, :create]
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
end
