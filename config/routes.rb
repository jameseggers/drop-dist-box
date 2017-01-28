require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  scope '/app' do
    resources :node_types
    resources :nodes
    resources :users
    resources :dist_files
    get 'dist_file/:id/download' => 'dist_files#download', as: "download_dist_file"
  end

  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
