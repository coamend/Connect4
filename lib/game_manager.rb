require 'singleton'
require 'board'
require 'player'

class GameManager
    include Singleton

    attr_reader :board, :players, :current_player
    
    def new_game(columns, rows, players)
        @board = Board.new(rows, columns, players)

        @players = Array.new(players.length) { |i| Player.new(players[i], @board) }

        @current_player = players.first
    end

    def add_token(player, column)
        placed = false

        if winning_player.nil?
            if player != @current_player
                puts 'Nacho turn! player: ' + player.to_s + ' does not match: ' + @current_player.to_s         
            else
                placed = board.add_token(player, column)
            end  

            set_next_player(player) if placed
        end

        placed      
    end
    
    def set_next_player(player)
        player_index = 0

        @players.each_with_index do |test_player, index|
            if test_player.name == player
                player_index = index
            end
        end

        player_index += 1
                
        if player_index >= @players.length
            player_index = 0
        end

        @current_player = @players[player_index].name
    end

    def winning_player
        victor = nil

        @players.each do |player|
            victor = player.name if player.won?
        end

        victor
    end
end