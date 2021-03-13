class Bowling_Scorecard
  attr_reader :frame, :scorecard

  def initialize
    @frame = 1
    @rolls_in_frame = 0
    @scorecard = {1 => []}
    @bonus_queue = {}
    @game_finished = false
    @frame_ten_strike = false
  end

  def record_roll(input)
    if @scorecard[10]
      raise "Game is finished!" if @scorecard[10].length == 2 unless @bonus_queue[10]
      raise "Game is finished!" if @rolls_in_frame == 3
    end
    # @frame == 10 && @rolls_in_frame == 3


    @rolls_in_frame += 1 
    process_bonuses(input)
    
    start_new_frame(1) if frame_finished? unless @frame == 10

    ###
    # basically if frame 10 has bonus_queue do 1 more roll, otherwise end
    # manually update spare for frame 10, i.e. 10, 0 would be a spare as well
    # if frame 10 and 3 rolls, game ends
    ##

    # set to 1 to acknowledge and process first roll of new frame 
    

      @scorecard[@frame] << input

    # if @frame == 10 && @rolls_in_frame == 2 && frame_score(10) < 10
    #   @game_finished = true
    # end

    # if @frame == 10 && @rolls_in_frame == 1 && input == 10
    #   @frame_ten_strike = true
    # end

    if spare? 
      add_to_bonus_queue(@frame, :spare, 1) #update to remove 3rd param, do it by spare/strike with ternary
      start_new_frame(0) unless @frame == 10
    end

    #bonus process
    if strike?
      add_to_bonus_queue(@frame, :strike, 2)
      start_new_frame(0) unless @frame == 10
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

  def spare?
    @rolls_in_frame == 2 && frame_score(@frame) == 10 && @scorecard[@frame][0] != 10 
    # check that first score of frame wasnt 10
  end
  
  def strike?
    @rolls_in_frame == 1 && frame_score(@frame) == 10
  end

  def frame_finished?
    @rolls_in_frame == 3 
  end

  def game_finished?
    @game_finished
  end


  def frame_score(frame_number)
    ## only available where frames have been completed
    # raise "Score for #{frame_number} unavailable" unless @scorecard[frame_number]
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