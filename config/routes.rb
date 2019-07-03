Rails.application.routes.draw do
  root "editions#index"

  resources :editions
  resources :tasks
end
