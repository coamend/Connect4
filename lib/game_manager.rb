require 'singleton'
# require 'board'
require 'cell'

class GameManager
    include Singleton

    attr_reader :board
    attr_reader :player_names
    attr_reader :current_player
    
    def new_game(columns, rows, players)
        @board = Array.new(rows) { Array.new(columns) { Cell.new } }

        @player_names = Array.new(players)
        @current_player = players.first
    end

    def add_token(player, column)
        placed = false

        if player != @current_player
            puts 'Nacho turn! player: ' + player.to_s + ' does not match: ' + current_player.to_s         
        elsif
            if board.last[column].token != nil
                # Column is full, can't place more
                puts 'No room at the inn!'
            else
                board.each_with_index do |row,i|
                    if row[column].token == nil
                        row[column].token = player
                        set_next_player(player)
                        placed = true
                        break
                        #TODO - add delegate to notify game of placed token
                    end
                end
            end
        end  

        placed      
    end

    def winning_player
        board.each do |row|
            row.each do |cell|
            end
        end
        
        nil
    end
    
    def set_next_player(player)
        player_index = player_names.index(player)

        player_index += 1
                
        if player_index >= player_names.length
            player_index = 0
        end

        @current_player = player_names[player_index]
    end
end