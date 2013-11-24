module Tennis

  
  class Game
    attr_accessor :player1, :player2

    def initialize( player1= Player.new(serving:true), player2= Player.new(serving:false) )
      @player1 = player1
      @player2 = player2
 
      @player1.serving = true
      @player2.serving = false

      @player1.opponent = @player2
      @player2.opponent = @player1
    end

    # Records a win for a ball in a game.
    #
    # winner - The Player Object that wins the ball.
    #
    # Returns the score of the winning player. 
    def wins_ball(winner)
      winner.record_won_ball!
    end

    # Figures out the proper tennis term for the players' scores. 
    #
    # Returns a String describing the game's score. 
    def report_scores
      if player1.points >= 3 && player1.points == player2.points
        return "The score is deuce!"
      elsif  player1.points >= 4 || player2.points >= 4
        
        if player1.points >= 4 && player1.points == (player2.points + 1) 
          return "The score is ad in."
        elsif player2.points >= 4 && player1.points == (player2.points - 1)
          return "The score is ad out."
        elsif player1.points >= (player2.points + 2)
          return "Game Over! The server wins!"
        else
          return "Game Over! The receiver wins!"
        end
      
      else
        return "The score is #{player1.score}, #{player2.score}."
      end
    end


  end



  class Player
    attr_accessor :points, :opponent, :serving

    def initialize(serving:false)
      @points = 0
      @serving = serving
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
      return 'more than forty' if points >= 4
 
    end

  end

end