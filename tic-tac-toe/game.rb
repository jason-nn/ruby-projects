require './player.rb'
require './tic_tac_toe.rb'

2.times { Player.create }

players = Player.list

player1 = players[0]
player2 = players[1]

TicTacToe.new(player1, player2)
