require 'bowling_scorecard'

describe Bowling_Scorecard do
  it "can record a user's roll" do
    # card = Bowling_Scorecard.new
    # expect(subject).to respond_to(:record_roll)
    
    subject.record_roll(6)
    expect(subject.total_score).to eq 6
  end
  
  describe 'frames' do
    it "can record a frame and track its score" do
      subject.record_roll(6)
      subject.record_roll(2)
      subject.record_roll(3)
      subject.record_roll(8)
      subject.record_roll(1)
      expect(subject.frame_score(1)).to eq 8
      expect(subject.frame_score(2)).to eq 11
      expect(subject.frame_score(3)).to eq 1
    end
    
    describe '10th frame' do
      it "ends game if no strike or spare after two rolls" do
        18.times { subject.record_roll(3) } # first 9 frames
        subject.record_roll(3)
        subject.record_roll(2)
        expect{ subject.record_roll(4) }.to raise_error "Game is finished!"
        expect(subject.frame_score(10)).to eq 5
      end
      # it "provides a 3 roll frame if first roll is a strike" do
      #   18.times { subject.record_roll(3) } # first 9 frames
      #   subject.record_roll(10)
      #   subject.record_roll(3)
      #   subject.record_roll(6)
      #   expect(subject.frame_score(10)).to eq 19
      #   expect{ subject.record_roll(4) }.to raise_error "Game is finished!"
      # end
    end
    
    
  end

  describe 'bonuses' do
    describe "strikes" do
      it "records a strike and updates frame accordingly" do
        subject.record_roll(10)
        expect(subject.frame).to eq 2
        subject.record_roll(6)
        subject.record_roll(4)
        subject.record_roll(10)
        expect(subject.frame).to eq 4
      end
      it "adds bonus points from next two rolls" do
        subject.record_roll(10)
        subject.record_roll(2)
        subject.record_roll(3)
        subject.record_roll(3)
        expect(subject.frame_score(1)).to eq 15
      end
    end
    describe "spares" do
      it "processes spare and adds bonus points of next roll" do
        subject.record_roll(3)
        subject.record_roll(7)
        subject.record_roll(3)
        subject.record_roll(3)
        expect(subject.frame_score(1)).to eq 13
        subject.record_roll(6)
        subject.record_roll(4)
        subject.record_roll(4)
        expect(subject.frame_score(3)).to eq 14
      end

    end

  end

end