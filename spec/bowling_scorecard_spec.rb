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
    
    it "takes 3 rolls in the last (10th) frame and ends the game" do
      18.times { subject.record_roll(3) }
      subject.record_roll(2)
      subject.record_roll(3)
      subject.record_roll(6)
      expect(subject.frame_score(10)).to eq 11
      expect{ subject.record_roll(4) }.to raise_error "Game is finished!"
    end
      
  end

end