class UsersController < ApplicationController
  def create 
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password], 
      password_confirmation: params[:password_confirmation]
      )
    if user.save
      render json: {message: "New user saved successfully."}
    else 
      render json: {message: user.errors.full_messages}, status: :bad_request
    end 
  end 

  def update
    user_id = params["id"]
    user = user.find_by(id: product_id)
    user.name = params["name"]
    user.email = params["email"]
    user.password = params["password"]
    if user.save
      render json: {message: "User updated successfully."} 
    else 
      render json: {error: user.errors.full_messages}, status: :bad_request
    end 
  end
end
