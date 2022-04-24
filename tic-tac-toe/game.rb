require './player.rb'
require './tic_tac_toe.rb'

2.times { Player.create }

TicTacToe.start_game(Player.list[0], Player.list[1])
