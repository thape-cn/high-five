namespace :api do
  resources :contracts, only: %i[update show]
end
