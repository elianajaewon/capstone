class User < ApplicationRecord
  has_secure_password
  
  has_many :user_dogs
  has_many :breeds, through: :user_dogs

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
