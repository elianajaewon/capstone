Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  get "/users/:id" => "users#show"
  post "/users" => "users#create"
  patch "/users/:id" => "users#update"

  get "/dogs" => "dogs#index"
  get "/dogs/:id" => "dogs#show"
end