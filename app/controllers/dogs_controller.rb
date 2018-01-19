class DogsController < ApplicationController
  def index
    dogs = Dog.all
    if params[:search]
      dogs = dogs.where("name ILIKE ?", "%#{params[:search]}%")
    end 
    render json: dogs.as_json
  end

  def show
    dog_id = params["id"]
    dog = Dog.find_by(id: dog_id)
    render json: dog.as_json
  end
end