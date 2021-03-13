class Bowling_Scorecard
  attr_reader :frame

  def initialize
    @frame = 1
    @rolls_in_frame = 0
    @scorecard = {1 => []}
    @bonus_queue = {}
  end

  def record_roll(input)
    raise "Game is finished!" if game_finished?

    @rolls_in_frame += 1 
    process_bonuses(input)

    if @rolls_in_frame == 3 && @frame != 10
      start_new_frame(1) # acknowledges first roll of new frame
    end
    
    @scorecard[@frame] << input

    #bonus process
    if @rolls_in_frame == 1 && input == 10
      add_to_bonus_queue(@frame, :strike, 2)
      start_new_frame(0)
    end
  end

  def process_bonuses(bonus_score)
    # filter queue where rolls left > 0
    queue = @bonus_queue.select {|k,v| v[:rolls_left] > 0}
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

  def game_finished?
    @frame == 10 && @rolls_in_frame == 3
  end


  def frame_score(frame_number)
    ## only available where frames have been completed
    # raise "Frame not started" unless frame_number <= @frame
    @scorecard[frame_number].inject(0){| sum, x | sum + x } # sums two scores in the frame
  end
  
  def total_score
    sum = 0
    @scorecard.each do |frame, score|
      score.each do |value|
        sum += value # value of hash arrays
      end
    end
    sum
  end

end