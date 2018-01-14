class UsersController < ApplicationController
  # before_action :authenticate_user, except: [:create] 

  def show
    user_id = params["id"]
    if user_id == "me"
      user = current_user
    else
      user = User.find_by(id: user_id)
    end
    render json: {message: user.as_json}  
  end

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
    # user_id = params["id"]
    # if user_id == "me"
    #   user = current_user
    # else 
    #   user = User.find_by(id: user_id)
    # end
    user = current_user
    user.zip_code = params[:zip_code]
    user.work_hours = params[:work_hours]
    user.home_type = params[:home_type]
    user.allergies = params[:allergies]
    user.noise_level = params[:noise_level]
    user.kids = params[:kids]
    user.pets = params[:pets]
    user.activity_level = params[:activity_level]
    if user.save 
      render json: {message: "User updated successfully!"}
    else
      render json: {message: "Please log in first."}
    end
  end
end
