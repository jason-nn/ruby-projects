require './colorize.rb'
require './words.rb'

class Wordle
  include Colorize
  include Words

  def initialize
    @tries = 6
    @answer = random_word
    @game_over = false
    @history = []

    instructions
    try until @game_over
  end

  def self.start_game
    Wordle.new
  end

  private

  def instructions
    puts
    puts 'Guess the Wordle in six tries.'
    puts
    puts 'Each guess must be a five-letter word. Hit the enter button to submit.'
    puts
    puts 'After each guess, you will be shown how close your guess was to the word.'
    puts
    puts 'Examples'
    puts
    puts "#{green('w')}eary - The letter W is in the word and in the correct spot."
    puts
    puts "p#{yellow('i')}lls - The letter I is in the word but in the wrong spot."
    puts
    puts "vag#{gray('u')}e - The letter U is not in the word in any spot."
    puts
  end

  def try
    guess = get_guess

    check_result(guess)
    @tries -= 1
  end

  def get_guess
    print 'Enter a 5 letter word: '
    guess = gets.chomp
    puts

    until guess.length == 5 && /^[A-Za-z]+$/.match(guess)
      puts 'Guess should be 5 letters'
      print 'Enter a 5 letter word: '
      guess = gets.chomp
      puts
    end

    return guess
  end

  def check_result(guess)
    #
  end
end
