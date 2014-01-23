Cats99::Application.routes.draw do
  root to: 'cats#index'

  resources :cats

  resources :cat_rental_requests, only: [:create, :new] do
    member do
      put 'approve'
      put 'deny'
    end
  end

  resources :users, only: [:create, :new]

  resources :sessions, only: [:create, :new, :destroy]
end
