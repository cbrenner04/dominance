Rails.application.routes.draw do
  devise_for :users
  resources :games, only: %i[index create update] do
    resources :rounds, only: %i[index new create]
  end
  root to: 'games#index'
end
