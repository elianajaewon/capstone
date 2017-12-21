Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  post "/users" => "users#create"

  get "/dogs" => "dogs#index"
  get "/dogs/:id" => "dogs#show"
end
