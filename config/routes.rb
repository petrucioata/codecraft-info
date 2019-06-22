Rails.application.routes.draw do
  root "editions#index"

  resources :editions, only: [:index, :show]
  # get 'editions/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
