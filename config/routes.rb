Rails.application.routes.draw do
  root "editions#index"

  resources :editions
end
