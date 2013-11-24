require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../tennis'

describe Tennis::Game do
  let(:game) { Tennis::Game.new }

  describe '.initialize' do
    it 'creates two players' do
      expect(game.player1).to be_a(Tennis::Player)
      expect(game.player2).to be_a(Tennis::Player)
    end

    it 'sets the opponent for each player' do
      expect(game.player1.opponent).to eq(game.player2)
      expect(game.player2.opponent).to eq(game.player1)
    end
  end

  describe '#wins_ball' do
    it 'increments the points of the winning player' do
      game.wins_ball(game.player1)
      expect(game.player1.points).to eq(1)

      game.wins_ball(game.player2)
      expect(game.player2.points).to eq(1)

      game.wins_ball(game.player2)
      expect(game.player2.points).to eq(2)
    end
  end

  describe '#report_scores' do
    it 'returns both players scores, or the ad-in, ad-out, deuce, or won/loss status' do
      game.player1.points = 0
      game.player2.points = 0
      expect(game.report_scores).to eq("The score is love, love.")

      game.player1.points = 1
      game.player2.points = 0
      expect(game.report_scores).to eq("The score is fifteen, love.")

      game.player1.points = 3
      game.player2.points = 3
      expect(game.report_scores).to eq("The score is deuce!")

      game.player1.points = 4
      game.player2.points = 3
      expect(game.report_scores).to eq("The score is ad in.")

      game.player1.points = 7
      game.player2.points = 8
      expect(game.report_scores).to eq("The score is ad out.")

      game.player1.points = 4
      game.player2.points = 2
      expect(game.report_scores).to eq("Game Over! The server wins!")

      game.player1.points = 2
      game.player2.points = 4
      expect(game.report_scores).to eq("Game Over! The receiver wins!")
    end
  end

end



describe Tennis::Player do
  let(:player) do
    player = Tennis::Player.new(serving:true)
    player.opponent = Tennis::Player.new(serving:false)

    return player
  end

  describe '.initialize' do
    it 'sets the points to 0' do
      expect(player.points).to eq(0)
    end 
  end

  describe '#record_won_ball!' do
    it 'increments the points' do
      player.record_won_ball!

      expect(player.points).to eq(1)
    end
  end

  describe '#score' do

    context 'when points is 0' do
      it 'returns love' do
        expect(player.score).to eq('love')
      end
    end
    
    context 'when points is 1' do
      it 'returns fifteen' do
        player.points = 1

        expect(player.score).to eq('fifteen')
      end 
    end
    
    context 'when points is 2' do
      it 'returns thirty' do
        player.points = 2

        expect(player.score).to eq('thirty')
      end
    end
    
    context 'when points is 3' do
      it 'returns forty' do
        player.points = 3

        expect(player.score).to eq('forty')
      end
    end

    context 'when points is 4 and the other opponent has less than 3 points' do
      it 'returns that the game has been won' do
        player.points = 4

        expect(player.score).to eq('Game Over! Winner!')
      end
    end

    context 'Ad-in : when a player has enough points to win, but does not have two more points than the opponent, and therefore is not yet the winner' do
      it 'returns that the advantage is with the player' do
        player.points = 4
        player.opponent.points = 3

        expect(player.score).to eq('Ad-in')

        player.points = 2
        player.opponent.points = 0
        expect(player.score).to eq('thirty')

        player.points = 55
        player.opponent.points = 54
        expect(player.score).to eq('Ad-in')
      end
    end

    context 'Ad-out: when a player opponent has enough points to win, but does not have two more points than the player, and therefore is not yet the loser' do
      it 'returns that the advantage is with the opponent' do
        player.points = 3
        player.opponent.points = 4

        expect(player.score).to eq('Ad-out')

        player.points = 0
        player.opponent.points = 2
        expect(player.score).to eq('love')

        player.points = 54
        player.opponent.points = 55
        expect(player.score).to eq('Ad-out')
      end
    end

    context 'Deuce: when a player and opponent both have the same number of points, and that number is greater than or equal to 3 (forty)' do
      it 'returns the the score is at deuce' do
        player.points = 2
        player.opponent.points = 2

        expect(player.score).to eq('thirty')

        player.points = 3
        player.opponent.points = 3
        expect(player.score).to eq('deuce!')

        player.points = 54
        player.opponent.points = 54
        expect(player.score).to eq('deuce!')
      end
    end

  end

end