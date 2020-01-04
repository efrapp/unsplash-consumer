Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'photos#index'
  
  get 'collections/favorite'
  get 'photos/:unsplash_id/add_to_favorites', to: 'photos#add_to_favorites', as: 'photos_add_to_favorites'

  resources :photos, only: :index
end
