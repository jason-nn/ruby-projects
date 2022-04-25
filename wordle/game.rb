require './wordle.rb'
require './colorize.rb'

class Game
  include Colorize

  def initialize
    @stop = false
    start

    start until @stop
  end

  def start
    Wordle.start_game
    @stop = true unless play_again
  end

  def play_again
    print 'Play again? (y/n) '
    answer = gets.chomp
    puts

    until answer == 'y' || answer == 'n'
      puts red('Invalid input.')
      puts
      print 'Play again? (y/n) '
      answer = gets.chomp
      puts
    end

    return true if answer == 'y'
    return false if answer == 'n'
  end
end

Game.new
