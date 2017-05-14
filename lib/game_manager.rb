require 'singleton'

class GameManager
    include Singleton

    attr_reader :board

    def new_game(columns, rows)
        @board = Array.new(rows) { Array.new(columns) }
    end
end