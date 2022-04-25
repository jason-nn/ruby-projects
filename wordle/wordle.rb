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
    check_guess(guess)
    @tries -= 1
    check_game_over(guess)
  end

  def get_guess
    puts "You have #{@tries} tries left."
    puts
    print 'Enter a 5 letter word: '
    guess = gets.chomp.downcase
    puts

    until guess.length == 5 && /^[A-Za-z]+$/.match(guess)
      puts red('Guess should be 5 letters.')
      puts
      print 'Enter a 5 letter word: '
      guess = gets.chomp.downcase
      puts
    end

    return guess
  end

  def check_guess(guess)
    result = ''
    guess.each_char.with_index do |char, i|
      if char == @answer[i]
        result += "#{green(char)}"
      elsif @answer.include? char
        result += "#{yellow(char)}"
      else
        result += "#{gray(char)}"
      end
    end
    puts result
    puts
    # add history
  end

  def check_game_over(guess)
    if @answer == guess
      puts 'Congratulations, you guessed the word!'
      puts
      end_game
    elsif @tries == 0
      puts 'Sorry! You ran out of tries.'
      puts
      puts "The word is #{@answer}."
      end_game
    end
  end

  def end_game
    @game_over = true
    # show history
  end
end
