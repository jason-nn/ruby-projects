require './hangman.rb'
require './colorize.rb'
require 'json'

class Game
  include Colorize

  def initialize
    saved_games = Dir.glob('saved/*')
    if saved_games.length > 0
      get_answer ? choose_game(saved_games) : new_game
    else
      new_game
    end
  end

  private

  def new_game
    Hangman.new
  end

  def get_answer
    puts
    print 'You have saved games. Would you like to continue from one of your saved games? (y/n) '
    answer = gets.chomp
    puts

    until answer == 'y' || answer == 'n'
      puts red('Invalid input. Try again.')
      puts
      print 'You have saved games. Would you like to continue from one of your saved games? (y/n) '
      answer = gets.chomp
      puts
    end

    return true if answer == 'y'
    return false if answer == 'n'
  end

  def choose_game(saved_games)
    puts 'These are your saved games:'
    puts
    saved_games.each { |filename| puts filename }
    puts
    print 'Which game would you like to continue? Enter the file name here: '
    selected_game = gets.chomp
    puts

    until saved_games.include? selected_game
      puts red('Invalid input. Try again.')
      puts
      print 'Which game would you like to continue? Enter the file name here: '
      selected_game = gets.chomp
      puts
    end

    file = File.open(selected_game, 'r')
    game_data = JSON.parse file.read
    file.close

    Hangman.new(
      game_data['game_over'],
      game_data['chances'],
      game_data['letters'],
      game_data['right_guesses'],
      game_data['wrong_guesses'],
      game_data['answer'],
      game_data['progress'],
    )
  end
end

Game.new
