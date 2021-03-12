class Bowling_Scorecard
  attr_reader :frame

  def initialize
    @frame = 1
    @rolls_in_frame = 0
    @scorecard = {1 => []}
  end

  def record_roll(input)
    if @frame == 10 && @rolls_in_frame == 3
      raise "Game is finished!"
    end
    
    @rolls_in_frame += 1 
    
    if @rolls_in_frame == 3 && @frame != 10
      #record first roll for new new frame
      @frame += 1 
      @scorecard[@frame] = []
      @rolls_in_frame = 1 
    end

    
    @scorecard[@frame] << input
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