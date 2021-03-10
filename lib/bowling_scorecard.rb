class Bowling_Scorecard
  attr_reader :frame

  def initialize
    @frame = 1
    @rolls = 0
    @score = 0
  end

  def record_roll(input)
    @rolls += 1 
    @frame += 1 if @rolls % 2 == 0 
    
    @score += input
  end

  def total_score
    @score
  end

end