class User < ApplicationRecord
  has_secure_password
  
  has_many :user_dogs
  has_many :breeds, through: :user_dogs

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true


  def dogs_with_incompatibilities
    dogs = []

    Dog.all.each do |dog|
      incompatibilities = []
      if work_hours == "I work 9-5" && dog.age == "puppy"
        incompatibilities << "not home enough"
      elsif home_type == "Apartment" && dog.size == "giant"
        incompatibilities << "not enough space"
      elsif allergies == "yes" && dog.grooming == "sheds a lot"
        incompatibilities << "too sheddy" 
      elsif noise_level.to_i < 3 && dog.bark_level == "very noisy"
        incompatibilities << "too noisy"
      elsif kids == "yes" && dog.kid_friendly == "no"
        incompatibilities << "not kid friendly"
      elsif pets == "yes" && dog.pet_friendly == "no"
        incompatibilities << "not pet friendly"
      elsif activity_level == "couch potato" && dog.exercise == "very active"
        incompatibilities << "too active"
      end
      dogs << {id: dog.id, breed: dog.breed, incompatibilities: incompatibilities}
    end

    return dogs
  end

end
