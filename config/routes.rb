Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :diaries
  resources :genres, only: [:new, :create, :destroy]
  root to: 'diaries#index'

end
