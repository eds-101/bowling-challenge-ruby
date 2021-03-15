class Bowling_Scorecard
  attr_reader :frame, :scorecard

  def initialize
    @frame = 1
    @rolls_in_frame = 0
    @scorecard = {1 => []}
    @bonus_queue = {}
  end

  def record_roll(input)
    raise "Game is finished!" if @scorecard[10] && @scorecard[10].length == 3 

    @rolls_in_frame += 1 
    process_bonuses(input)
    start_new_frame(1) if frame_finished_no_bonus? # records input as first roll of new frame

    @scorecard[@frame] << input
    return "Perfect Game!" if total_score == 300
    
    process_spares
    process_strikes

    if frame_ten_no_bonus?
      @scorecard[10] << 0
      return "Gutter Game!" if total_score == 0
    end

  end

  def process_spares
    if spare? 
      add_to_bonus_queue(@frame, :spare, 1) unless @frame == 10 
      start_new_frame(0) unless @frame == 10
    elsif spare? && @frame == 10
      add_to_bonus_queue(@frame, :spare, 0)
      @rolls_in_frame = 0 # to allow for another strike
    end
  end

  def process_strikes
    if strike?
      add_to_bonus_queue(@frame, :strike, 2) unless @frame == 10
      start_new_frame(0) unless @frame == 10
    elsif strike? && @frame == 10
      add_to_bonus_queue(@frame, :strike, 0)
      @rolls_in_frame = 0 # to allow for another strike
    end
  end

  def process_bonuses(bonus_score)
    queue = @bonus_queue.select {|k,v| v[:rolls_left] > 0} # filter queue where rolls left > 0
    # add bonus, reduce rolls left to process
    queue.each do |frame, values|
      @scorecard[frame] << bonus_score
      @bonus_queue[frame][:rolls_left] -= 1
    end

  end

  def add_to_bonus_queue(frame, scenario, rolls_left)
    @bonus_queue[frame] = { scenario: scenario, rolls_left: rolls_left }
  end
  
  def start_new_frame(rolls)
    @frame += 1 
    @scorecard[@frame] = []
    @rolls_in_frame = rolls 
  end

  
  def frame_score(frame_number)
    raise "Score for #{frame_number} unavailable" unless @scorecard[frame_number]
    @scorecard[frame_number].inject(0){| sum, x | sum + x } # sums two scores in the frame
  end
  
  def total_score
    sum = 0
    @scorecard.each do |frame, score|
      score.each do |value|
        sum += value # sum of arrays
      end
    end
    sum
  end
  
  def spare?
    @rolls_in_frame == 2 && frame_score(@frame) == 10 && @scorecard[@frame][0] != 10 
    # check that first score of frame wasnt 10
  end
  
  def strike?
    @rolls_in_frame == 1 && frame_score(@frame) == 10
  end

  def frame_finished_no_bonus?
    @rolls_in_frame == 3 && @frame != 10
  end

  def frame_ten_no_bonus?
    @rolls_in_frame == 2 && @frame == 10 && frame_score(10) < 10
  end

end