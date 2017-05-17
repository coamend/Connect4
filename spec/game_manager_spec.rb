require 'game_manager'
require 'spec_helper'

RSpec.describe "Game Manager" do
    let(:game_manager) { GameManager.instance }
    let(:columns) { 7 }
    let(:rows) { 6 }
    let(:player_1) { 'Player_1' }
    let(:player_2) { 'Player_2' }

    before(:each) { game_manager.new_game(columns,rows,[player_1, player_2]) }

    describe "when starting a new game" do
        it "creates a new game board" do
            expect(game_manager.board.length).to eq(rows)
            expect(game_manager.board.last.length).to eq(columns)
        end
    end

    describe "when placing a token" do
        describe "when it is the players turn" do
            it "places the token on the board" do
                expect(game_manager.add_token(player_1, 3)).to be true
                expect(game_manager.board[0][3].token).to eq(player_1)
            end
        end

        describe "when it is not the players turn" do
            it "does not place the token on the board" do
                expect(game_manager.add_token(player_2, 3)).to be false
            end
        end

        describe "when the column is full" do
            it "does not place the token on the board" do
                alternate = false
                do rows.times
                    unless alternate
                        game_manager.add_token(player_1, 3)
                    else
                        game_manager.add_token(player_2, 3)
                    end
                    alternate = !alternate
                end
                expect(game_manager.add_token(player_1, 3)).to be false
        end
    end
end

