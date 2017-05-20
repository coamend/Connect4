class Player
    attr_accessor :name
    attr_reader :values

    def initialize(player_name, board)
        @name = player_name
        @board = board
        @values = Array.new(board.rows) { Array.new(board.columns) { 0 } }
        @victor = false

        board.add_observer(self, :board_update)
    end

    def board_update(player, column, row)
        values[row][column] == -1 #flag current spot as valueless

        # check for horizontal values
        run = 0
        @board[row].each_with_index do |column,x|
            if column.token == @name
                run += 1
            elsif column.token.nil?
                values[row][x] = run # hit right edge of run
                if !@board.left_edge?(x - run) && @board[row][x - run - 1].token.nil?
                    values[row][x - run - 1] = run
                end

                assign_victory(run)
                run = 0
            else
                # hit right edge of run, other player stopped
                if !@board.left_edge?(x - run) && @board[row][x - run - 1].token.nil?
                    values[row][x - run - 1] = run
                end

                assign_victory(run)
                run = 0
            end
        end
        
        # check for vertical values
        run = 0
        @board.each_with_index do |row,y|
            if row[column].token == @name
                run += 1
            elsif row[column].token.nil?
                values[y][column] = run # hit top edge of run

                assign_victory(run)
                run = 0
            else
                # hit top edge of run, other player stopped
                assign_victory(run)
                run = 0
            end
        end
        
    end

    def assign_victory(run)
        puts 'run = ' + run.to_s
        @victor = true if run >= 4 && @victor == false
    end

    def won?
        @victor
    end
end
