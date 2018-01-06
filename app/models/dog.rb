class Dog < ApplicationRecord
  has_many :user_dogs
  has_many :users, through: :user_dogs
  has_many :images

  # def incompatibilities
  #   # if current_user.noise_level == 1
  #   #   return dog.breed.where(bark_level: quiet)
  #   # elsif current_user.noise_level == 2 
  #   #   return bark_level.quiet
  #   # elsif current_user.noise_level == 3 
  #   #   return bark_level.
  #   # elsif current_user.noise_level == 4 
  #   #   return bark_level.quiet
  #   # elsif current_user.noise_level == 5 
  #   #   return bark_level.very_noisy
  #   # end
  #   incompatibilities = []
  #   if current_user.noise_level < 3 && bark_level == "very noisy"
  #     incompatibilities << "too noisy"
  #   elsif current_user.allergies == "yes" && grooming == "sheds a lot"
  #     incompatibilities << "too sheddy" 
  #   end
  #   return incompatibilities
  # end

  def as_json
    {
      breed: breed,
      size: size,
      grooming: grooming,
      bark_level: bark_level,
      kids: kids,
      pets: pets,
      exercise: exercise,
      incompatibilities: incompatibilities
    }
  end
end
