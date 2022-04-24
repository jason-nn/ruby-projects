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
    puts "It's #{@current_player.name}'s turn using the symbol #{symbol}"
    puts

    show_board
    selected_cell = get_selected_cell
    puts

    if !@board.flatten.include? selected_cell || selected_cell == 'X' ||
                                 selected_cell == 'O'
      puts 'That is not a valid input'
      selected_cell = get_selected_cell
      puts
    end

    place_symbol(selected_cell)
  end

  def symbol_wins?(symbol)
    # horizontal win
    @board.each { |row| return true if row.all? { |cell| cell == symbol } }

    # vertical win
    (0..@board.length - 1).each do |i|
      return true if @board.all? { |row| row[i] == symbol }
    end

    # diagonal win
    if (
         @board[0][0] == symbol && @board[1][1] == symbol &&
           @board[2][2] == symbol
       ) ||
         (
           @board[2][0] == symbol && @board[1][1] == symbol &&
             @board[2][0] == symbol
         )
      return true
    end

    # no one wins
    return false
  end

  def player1_wins?
    @winner = @player1 if symbol_wins?('X')
  end

  def player2_wins?
    @winner = @player2 if symbol_wins?('O')
  end

  def is_tie?
    @board.flatten.count('X') + @board.flatten.count('O') == 9
  end

  def game_over?
    @game_over = true if player1_wins? || player2_wins? || is_tie?
    @game_over
  end

  def announce_winner
    if @winner == nil
      puts "Game over! It's a tie"
    else
      puts "Game over! #{@winner.name} wins"
    end
    puts
    show_board
  end
end
