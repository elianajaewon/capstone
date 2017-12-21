class Dog < ApplicationRecord
  has_many :user_dogs
  has_many :users, through: :user_dogs
  has_many :images
end
