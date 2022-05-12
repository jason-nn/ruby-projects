require './words.rb'
require './colorize.rb'
require 'json'

class Hangman
  include Words
  include Colorize

  def initialize(
    game_over = false,
    chances = 8,
    letters = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z],
    right_guesses = [],
    wrong_guesses = [],
    answer = nil,
    progress = nil
  )
    @game_over = game_over
    @chances = chances
    @letters = letters
    @right_guesses = right_guesses
    @wrong_guesses = wrong_guesses
    @answer = answer || random_word.split('')
    @progress = progress || Array.new(@answer.length, '_')

    instructions if right_guesses.length == 0 && wrong_guesses.length == 0
    try until @game_over
  end

  private

  def instructions
    puts
    puts 'Welcome to Hangman!'
    puts
    puts "Guess the #{@answer.length} letter word to win."
    puts
    puts 'You can guess by entering a letter. If the letter is in the word, the corresponding blanks will be filled in.'
    puts
    puts "If not, then you can lose one of your #{@chances} chances."
    puts
    puts 'If you lose all your chances before guessing the word, you lose.'
    puts
    puts 'Before you guess, all letters will be shown.'
    puts
    puts 'Colored letters have been selected already and cannot be reselected.'
    puts
    puts "Correct guesses will be colored #{green('green')} while incorrect guesses will be colored #{red('red')}."
    puts
  end

  def try
    ask_save
    show_chances_left
    show_progress
    show_letters
    guess = get_guess
    check_guess(guess)
    check_game_over
  end

  def ask_save
    print 'Would you like to save your progress before moving forward? (y/n) '
    answer = gets.chomp
    puts

    until answer == 'y' || answer == 'n'
      puts red('Invalid input. Try again.')
      puts
      print 'Would you like to save your progress before moving forward? (y/n) '
      answer = gets.chomp
      puts
    end

    if answer == 'y'
      Dir.mkdir('saved') unless File.exists? 'saved'
      file = File.open("saved/#{@answer.map { |x| x.ord }.join('_')}.txt", 'w')
      file.puts JSON.dump(
                  {
                    game_over: @game_over,
                    chances: @chances,
                    letters: @letters,
                    right_guesses: @right_guesses,
                    wrong_guesses: @wrong_guesses,
                    answer: @answer,
                    progress: @progress,
                  },
                )
      file.close
    end
  end

  def get_guess
    print 'Enter a letter: '
    guess = gets.chomp.downcase
    puts

    until (@letters.include? guess) && !(@right_guesses.include? guess) &&
            !(@wrong_guesses.include? guess)
      puts red('Invalid letter. Try again.')
      puts
      print 'Enter a letter: '
      guess = gets.chomp.downcase
      puts
    end

    return guess
  end

  def show_chances_left
    puts "You have #{@chances} chances left."
    puts
  end

  def show_progress
    puts @progress.join(' ')
    puts
  end

  def show_letters
    @letters.each do |letter|
      if @right_guesses.include? letter
        print green(letter)
      elsif @wrong_guesses.include? letter
        print red(letter)
      else
        print letter
      end
      print(' ')
    end
    puts
    puts
  end

  def check_guess(guess)
    if @answer.include? guess
      puts green('The letter you guessed is in the word!')
      puts
      @answer.each_with_index do |letter, index|
        @progress[index] = guess if letter == guess
      end
      @right_guesses << guess
    else
      puts red('The letter you guessed is not in the word.')
      puts
      @chances -= 1
      @wrong_guesses << guess
    end
  end

  def check_game_over
    if @answer == @progress
      puts 'Congratulations, you guessed the word!'
      puts
      puts "The word is #{green(@answer.join(' '))}"
      puts
      end_game
    elsif @chances == 0
      puts 'Sorry! You ran out of chances.'
      puts
      puts "The word is #{green(@answer.join(' '))}."
      puts
      end_game
    end
  end

  def end_game
    @game_over = true
  end
end
