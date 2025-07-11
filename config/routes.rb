Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :account, module: "accounts" do
    resource :profile, only: %i[show update]
  end
  resource :good_events, only: %i[new create]
  resource :bad_events, only: %i[new create]

  resource :info, only: %i[show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show"

  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }
  get "auth/openid_connect/callback" => "openid_connect#callback"

  draw :admin
  draw :api

  namespace :ui do
    resource :avatar_area, only: %i[show]
    resources :nav_group_items, only: %i[] do
      collection do
        get :account
      end
    end
    resource :user_select, only: %i[show]
  end

  # Add workspace info route
  get "workspace/:id/info" => "workspace#info"

  root "home#index"

  constraints(id: /[#{User::LOGIN_FORMAT}]*/o) do
    resources :users, path: "", as: "users", only: %i[show]
  end
end
