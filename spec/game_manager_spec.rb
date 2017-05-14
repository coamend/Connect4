require 'game_manager'
require 'spec_helper'

RSpec.describe "Game Manager" do
    let(:game_manager) { GameManager.instance }
    let(:columns) { 7 }
    let(:rows) { 6 }

    describe "when starting a new game" do
        before(:each) { game_manager.new_game(columns,rows) }
        
        it "creates a new game board" do
            expect(game_manager.board.length).to eq(rows)
            expect(game_manager.board.last.length).to eq(columns)
        end
    end
end

