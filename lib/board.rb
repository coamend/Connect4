require 'cell'
require 'observer'

class Board
    include Observable

    attr_reader :board, :columns, :rows

    def initialize(rows, columns, players)
        @board = Array.new(rows) { Array.new(columns) { Cell.new } }
        @rows = rows
        @columns = columns
    end

    def add_token(player, column)
        placed = false

        if board.last[column].token != nil
            # Column is full, can't place more
            # puts 'No room at the inn!'
        else
            board.each_with_index do |row,row_i|
                if row[column].token == nil
                    row[column].token = player

                    changed
                    notify_observers(player, column, row_i)

                    placed = true
                    break
                    #TODO - add delegate to notify game of placed token
                end
            end
        end

        placed      
    end

    def left_edge?(column)
        column == 0
    end

    def right_edge?(column)
        column == @columns
    end

    def bottom_edge?(row)
        row == 0
    end
    
    def top_edge?(row)
        row == @rows
    end

    def method_missing(method, *args)
        if @board.respond_to?(method)
            @board.send(method, *args)
        else
            super
        end
    end
end
