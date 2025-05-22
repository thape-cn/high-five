namespace :admin do
  root to: "home#index"
  resources :contracts, only: %i[new create destroy] do
    member do
      get :invoke_ai
      get :confirm_destroy
    end
  end
  resources :users, only: %i[index edit update new create] do
    member do
      get :impersonation
      patch :sign_in_as
    end
  end
  resources :job_roles, only: %i[index edit update] do
    collection do
      get :excel_report
    end
  end
  resources :roles, only: %i[index new create edit update] do
    resources :role_users, only: %i[index]
    collection do
      get :expender
    end
  end
end
