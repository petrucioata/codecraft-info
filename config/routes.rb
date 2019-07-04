# frozen_string_literal: true

Rails.application.routes.draw do
  root 'editions#index'

  get 'editions/:id/import', to: 'editions#new_import', as: 'new_import_edition'
  post 'editions/:id', to: 'editions#import', as: 'import_edition'

  resources :editions
  resources :participants
end
