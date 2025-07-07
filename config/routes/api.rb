namespace :api do
  resources :contracts, only: %i[update show] do
    member do
      get :basic
      get :review
    end
  end
end
