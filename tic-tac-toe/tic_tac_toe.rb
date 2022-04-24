class TicTacToe
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @current_player = player1
    @game_over = false
  end

  def self.start_game(player1, player2)
    TicTacToe.new(player1, player2)
    puts "Starting Tic Tac Toe game between #{player1.name} and #{player2.name}"
    puts

    unless game_over?
      make_move
      switch_player unless game_over?
    end
  end

  private

  def show_board
    @board.each do |row|
      row.each { |cell| print " #{cell} " }
      puts
    end
  end

  def symbol
    @current_player == player1 ? 'X' : 'O'
  end

  def switch_player
    if @current_player == player1
      @current_player = player2
    else
      @current_player = player1
    end
  end

  def make_move
    # player makes move
  end

  def game_over?
    # check board to see if game is over
    # print result and set @game_over to true if game is over
    @game_over
  end
end
