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

        return if player != @name

        # check for horizontal values
        run = 0
        @board[row].map.each_with_index do |column,x|
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

            if @board.right_edge?(x)
                # hit right edge of run, right edge of board
                if !@board.left_edge?(x - run) && @board[row][x - run - 1].token.nil?
                    values[row][x - run - 1] = run
                end

                assign_victory(run)
                run = 0
            end
        end
        
        # check for vertical values
        run = 0
        @board.map.each_with_index do |row,y|
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

            if @board.top_edge?(y)
                assign_victory(run)
                run = 0
            end
        end
        
        # Check for diagonal right values
        run = 0
        bottom_edge = 0
        top_edge = 0

        # Scan down and to the left
        pos = 0
        unless @board.bottom_edge?(row + pos) || @board.left_edge?(column + pos)
            3.times do |i|
                pos = -i -1
                if @board[row + pos][column + pos].token == @name
                    bottom_edge += 1
                else
                    break
                end
                
                if @board.bottom_edge?(row + pos) || @board.left_edge?(column + pos)
                    break
                end
            end
        end

        # Scan up and to the right
        pos = 0
        unless @board.top_edge?(row + pos) || @board.right_edge?(column + pos)
            3.times do |i|
                pos = i + 1
                if @board[row + pos][column + pos].token == @name
                    top_edge += 1
                else
                    break
                end

                if @board.top_edge?(row + pos) || @board.right_edge?(column + pos)
                    break
                end
            end
        end
    
        assign_victory(top_edge + bottom_edge + 1)

        # Check for diagonal left values
        run = 0
        bottom_edge = 0
        top_edge = 0

        # Scan down and to the right
        pos = 0
        unless @board.bottom_edge?(row + pos) || @board.right_edge?(column - pos)
            3.times do |i|
                pos = -i -1
                if @board[row + pos][column - pos].token == @name
                    bottom_edge += 1
                else
                    break
                end
                
                if @board.bottom_edge?(row + pos) || @board.right_edge?(column - pos)
                    break
                end
            end
        end

        # Scan up and to the left
        pos = 0
        unless @board.top_edge?(row + pos) || @board.left_edge?(column - pos)
            3.times do |i|
                pos = i + 1
                if @board[row + pos][column - pos].token == @name
                    top_edge += 1
                else
                    break
                end

                if @board.top_edge?(row + pos) || @board.left_edge?(column - pos)
                    break
                end
            end
        end
    
        assign_victory(top_edge + bottom_edge + 1)
    end

    def assign_victory(run)
        @victor = true if run >= 4 && @victor == false
    end

    def won?
        @victor
    end
end
