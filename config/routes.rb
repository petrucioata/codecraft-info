Rails.application.routes.draw do
  root "editions#index"

  resources :editions
  resources :tasks
  resources :participants
end
