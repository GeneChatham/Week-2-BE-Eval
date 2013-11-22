module Tennis
  class Game
    attr_accessor :player1, :player2

    def initialize
      @player1 = Player.new
      @player2 = Player.new

      @player1.opponent = @player2
      @player2.opponent = @player1
    end

    # Records a win for a ball in a game.
    #
    # winner - The Player Object that wins the ball.
    #
    # Returns the score of the winning player. 
    def wins_ball(winner)
      winner.points += 1;

    end
  end



  class Player
    attr_accessor :points, :opponent

    def initialize
      @points = 0
      #@opponent = nil
    end

    # Increments the score by 1.
    #
    # Returns the integer new score.
    def record_won_ball!
      @points += 1
    end


    # Sets the 

    # Returns the String score for the player.
    def score
      return 'love' if @points == 0
    end
  end
end