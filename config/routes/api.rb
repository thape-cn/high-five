namespace :api do
  resources :contracts, only: %i[create show]
end
