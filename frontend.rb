require "unirest"
require "pp"

while true
  system "clear"
  puts "Welcome to the Dogs App! Please select an option."
  puts "[1] Show me my dogs"
  puts "[2] Search dogs by breed"
  puts "[3] Choose a dog breed to show"
  puts "[4] Fill out the survey!"
  puts
  puts "[signup] Sign up a new user"
  puts "[login] Log in"
  puts "[logout] Log out"
  puts 
  puts "[q] Quit"

  input_option = gets.chomp

  if input_option == "1"
    user_id = 3
    response = Unirest.get("http://localhost:3000/users/#{user_id}")
    user = response.body
    pp user
  elsif input_option == "2"
    puts "Enter a dog breed."
    dog_breed = gets.chomp
    puts "Here is your dog breed:"
    response = Unirest.get("http://localhost:3000/dogs/search=#{dog_breed}")
    dog = response.body 
    pp dog
  elsif input_option == "3"
    puts "Choose a dog ID:"
    dog_id = gets.chomp 
    response = Unirest.get("http://localhost:3000/dogs/#{dog_id}")
    dog = response.body
    pp dog
  elsif input_option == "4"
    params = {}
    puts "What is your zip code?"
    params[:zip_code] = gets.chomp
    puts "What best describes your work situation? (I work 9-5/I work from home)"
    params[:work_hours] = gets.chomp
    puts "What best describes your home? (House/Apartment)"
    params[:home_type] = gets.chomp
    puts "Do you have allergies to certain breeds? (Yes/Some/No)"
    params[:allergies] = gets.chomp
    puts "What is your noise tolerance on a scale of 1-5? (1/2/3/4/5)"
    params[:noise_level] = gets.chomp
    puts "Do you have kids? (Yes/No)"
    params[:kids] = gets.chomp
    puts "Do you have other pets? (Yes/No)"
    params[:pets] = gets.chomp
    puts "How would you best describe your lifestyle? (Very active/Somewhat active/Couch potato)"
    params[:activity_level] = gets.chomp
    response = Unirest.patch("http://localhost:3000/users", parameters: params)
    pp response.body

  elsif input_option == "signup"
    params = {}
    puts "Name: "
    params[:name] = gets.chomp 
    puts "Email: "
    params[:email] = gets.chomp 
    puts "Password: "
    params[:password] = gets.chomp 
    puts "Password confirmation: "
    params[:password_confirmation] = gets.chomp 
    response = Unirest.post("http://localhost:3000/users", parameters: params)
    pp response.body 
  elsif input_option == "login"
    params = {}
    puts "Please enter your email:"
    params[:email] = gets.chomp
    puts "Please enter your password:"
    params[:password] = gets.chomp
    response = Unirest.post("http://localhost:3000/user_token", parameters: {auth: {email: params[:email], password: params[:password]}})
    pp response.body 
    jwt = response.body["jwt"]
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif input_option == "logout"
  elsif input_option == "q"
    puts "Goodbye!"
    break
  end 
  puts "Press enter to continue"
  gets.chomp
end
