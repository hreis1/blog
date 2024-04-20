Rails.application.routes.draw do
  devise_for :users

  root "posts#index"

  resources "users", only: [ :show ]
  resources "posts" do
    resources "comments", only: [ :create ]
  end

  resources "tags", only: [ :show ]
end
