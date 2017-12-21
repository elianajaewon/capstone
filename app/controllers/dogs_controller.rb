class DogsController < ApplicationController
  def index
    dogs = Dog.all
    render json: dogs.as_json
  end
end
