require 'sinatra'
require 'sinatra/reloader'

$random_number = rand(100)

class Game
  @@attempts = 5
  
  def check_guess(guess, random_number)
    @@attempts -= 1
  
    if @@attempts >= 0
      if guess > $random_number + 5
        "Way too high!" 
      elsif guess < $random_number - 5
        "Way too low!"
      elsif guess > $random_number
        "Too high!"
      elsif guess < $random_number
        "Too low!"
      else
        new_game
        "You got it right! Guess again?"
      end
    else
      new_game  
      "GAME OVER! Guess again?"
    end
  end

  def new_game
    @@attempts = 5
    $random_number = rand(100)
  end

end
get '/' do
  guess = params["guess"].to_i
  play = Game.new
  message = play.check_guess(guess, $random_number)
  erb :index, :locals => {:number => $random_number, :message => message, :guess => guess, :attempts => Game.class_variable_get(:@@attempts)}
end