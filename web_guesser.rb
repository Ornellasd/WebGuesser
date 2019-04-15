require 'sinatra'
require 'sinatra/reloader'

set :random_number, rand(100)

def check_guess(guess, random_number)
  if guess > random_number + 5
    "Way too high!"
  elsif guess < random_number - 5
    "Way too low!" 
  elsif guess > random_number
    "Too high!"
  elsif guess < random_number
    "Too low"
  else
    "You got it right!"
  end
end

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess, settings.random_number)
  erb :index, :locals => {:number => settings.random_number, :message => message, :guess => guess }
end