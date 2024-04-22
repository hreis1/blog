require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources 'users', only: [:show]
  resources 'posts' do
    resources 'comments', only: [:create]
  end

  post 'posts/upload', to: 'posts#upload'

  resources 'tags', only: [:show] do
    get 'search', on: :collection
  end

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'admin' && password == 'admin'
  end
  mount Sidekiq::Web => '/sidekiq'
end
