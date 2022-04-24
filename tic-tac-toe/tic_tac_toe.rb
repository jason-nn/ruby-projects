class TicTacToe
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @board = [%w[a b c], %w[d e f], %w[g h i]]
    @game_over = false
    @winner = nil

    until game_over?
      make_move
      switch_player unless game_over?
    end

    announce_winner
  end

  def self.start_game(player1, player2)
    puts "Starting Tic Tac Toe game between #{player1.name} and #{player2.name}"
    puts

    TicTacToe.new(player1, player2)
  end

  private

  def show_board
    @board.each do |row|
      row.each { |cell| print " #{cell} " }
      puts
    end
    puts
  end

  def symbol
    @current_player == @player1 ? 'X' : 'O'
  end

  def switch_player
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def get_selected_cell
    print 'Enter the letter of the cell you want to place your symbol on: '
    return gets.chomp
  end

  def place_symbol(selected_cell)
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        @board[row_index][cell_index] = symbol if cell == selected_cell
      end
    end
  end

  def make_move
    puts "It's #{@current_player.name}'s turn"
    puts

    show_board
    selected_cell = get_selected_cell
    puts

    unless @board.flatten.include? selected_cell
      puts 'That is not a valid input'
      selected_cell = get_selected_cell
      puts
    end

    place_symbol(selected_cell)
  end

  def is_tie?
    @board.flatten.count('X') + @board.flatten.count('O') == 9
  end

  def player1_wins?
    #
    @winner = @player1
  end

  def player2_wins?
    #
    @winner = @player2
  end

  def game_over?
    @game_over = true if is_tie? || player1_wins? || player2_wins?
    @game_over
  end

  def announce_winner
    puts "Game over! It's a tie" if @winner == nil
    puts "Game over! #{@player1.name} wins" if @winner == @player1
    puts "Game over! #{@player2.name} wins" if @winner == @player2
    puts
    show_board
  end
end
