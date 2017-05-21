#!/usr/bin/env ruby

require 'optparse'
require_relative 'lib/game_manager'

options = {}

opt_parser = OptionParser.new do |opt|  
    opt.banner = "Usage: game COMMAND [OPTIONS]"
    opt.separator  ""
    opt.separator  "Commands"
    opt.separator  "     new: start a new game"
    opt.separator  ""
    opt.separator  "Options"

    opt.on("-p","--players NAME,NAME", Array, "set the name of the players in this game") do |players|
        options[:players] = players
    end

    opt.on("-c","--columns NUMBER","set the number of columns in this game") do |col|
        options[:col] = col
    end

    opt.on("-r","--rows NUMBER","set the number of rows in this game") do |row|
        options[:row] = row
    end

    opt.on("-h","--help","help") do
        puts opt_parser
    end
end

opt_parser.parse!  

case ARGV[0]  
when "new"  
    game_manager = GameManager.instance
    game_manager.new_game(options[:col].to_i, options[:row].to_i, options[:players])
    name_size = options[:players][0].to_s.length
    rows = options[:row].to_i - 1

    until !game_manager.winning_player.nil?
        system "clear" or system "cls"

        current_player = game_manager.current_player

        puts current_player + "'s turn!"
        puts options[:players].join(',')

        
        # Display the board
        line = ''
        game_manager.board[0].size.times do |col|
            line += ' '
            (name_size - 1).times { line += '-' }
            line += (col + 1).to_s
            line += ' '
        end
        puts line
        
        (rows + 1).times do |row|
            line = ''
            game_manager.board[rows - row].size.times do |col|
                line += '+'
                name_size.times { line += '-' }
                line += '+'
            end
            puts line

            line = ''
            game_manager.board[rows - row].size.times do |col|
                line += '|'
                if game_manager.board[rows - row][col].token.nil?
                    name_size.times { line += ' ' }
                else
                    line += game_manager.board[rows - row][col].token
                end
                line += '|'
            end
            puts line

            line = ''
            game_manager.board[rows - row].size.times do |col|
                line += '+'
                name_size.times { line += '-' }
                line += '+'
            end
            puts line
        end

        puts
        puts "Please enter a column to place a token (1 - " + options[:col].to_s + '):'

        played = STDIN.gets.chomp.to_i - 1 # convert column to index
        game_manager.add_token(current_player, played)
    end

    system "clear" or system "cls"
    puts game_manager.winning_player + ' wins!'
else  
    puts opt_parser
end  