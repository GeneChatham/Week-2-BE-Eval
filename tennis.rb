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
      winner.record_won_ball!;
#      return winner.points
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


    # Examines the @points of the player, and if necessary, the 
    #   player's opponent and decides which tennis score 
    #   phrase that refers to
    #
    # Returns the String score for the player.
    def score

      if (@points >= 4 && @points == (@opponent.points + 1) )
        return "Ad-in"
      elsif (@opponent.points >= 4 && @points == (@opponent.points - 1))
        return "Ad-out"
      elsif (@points >= 3 && @points == @opponent.points)
        return "deuce!"
      elsif (@points >= 4)
        return "Game Over! Winner!"
      end

      return 'love' if @points == 0
      return 'fifteen' if @points == 1
      return 'thirty' if @points == 2
      return 'forty' if @points == 3
 
    end

  end




end