Rails.application.routes.draw do
  resources :node_types
  resources :nodes
  devise_for :users
  resources :dist_files
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
