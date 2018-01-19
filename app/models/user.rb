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
      elsif work_hours == "I work 9-5" && dog.age == "young"
        incompatibilities << "not home enough"
      elsif home_type == "Apartment" && dog.size == "giant"
        incompatibilities << "not enough space"
      elsif home_type == "Apartment" && dog.size == "large"
        incompatibilities << "not enough space"
      elsif allergies == "yes" && dog.grooming == "sheds a lot"
        incompatibilities << "too sheddy" 
      elsif allergies == "yes" && dog.grooming == "sheds a little"
        incompatibilities << "too sheddy"
      elsif allergies == "some" && dog.grooming == "sheds a lot"
        incompatibilities << "too sheddy" 
      elsif noise_level.to_i < 2 && dog.bark_level == "very noisy"
        incompatibilities << "too noisy"
      elsif noise_level.to_i < 3 && dog.bark_level == "somewhat noisy"
        incompatibilities << "too noisy"
      elsif kids == "yes" && dog.kid_friendly == "no"
        incompatibilities << "not kid friendly"
      elsif pets == "yes" && dog.pet_friendly == "no"
        incompatibilities << "not pet friendly"
      elsif activity_level == "couch potato" && dog.exercise == "very active"
        incompatibilities << "too active"
      elsif activity_level == "somewhat active" && dog.exercise == "very active"
        incompatibilities << "too active"
      elsif activity_level == "very active" && dog.exercise == "lazy"
        incompatibilities << "too lazy"
      end

      if incompatibilities.length == 0 
        dogs << {id: dog.id, breed: dog.breed, description: dog.description, incompatibilities: incompatibilities}
      # else
      end
      # dogs << {id: dog.id, breed: dog.breed, incompatibilities: incompatibilities}
    end

    return dogs

  end

  def as_json
    {
      id: id,
      name: name,
      email: email,
      dogs: dogs_with_incompatibilities,
      zip_code: zip_code,
      work_hours: work_hours,
      home_type: home_type,
      allergies: allergies,
      noise_level: noise_level,
      kids: kids,
      pets: pets,
      activity_level: activity_level,
    }
  end
end
