require 'bowling_scorecard'

describe Bowling_Scorecard do
  it "can record a user's roll" do
    # card = Bowling_Scorecard.new
    # expect(subject).to respond_to(:record_roll)
    
    subject.record_roll(6)
    expect(subject.total_score).to eq 6
  end
  
  describe 'frames' do
    it "can update a frame after two rolls" do
      subject.record_roll(6)
      subject.record_roll(2)
      expect(subject.total_score).to eq 8
      expect(subject.frame).to eq 2
    end
    it "keeps track of scores for each frame" do
      4.times { subject.record_roll(3) }
      4.times { subject.record_roll(5) }
      expect(subject.frame_score(1)).to eq 6
      expect(subject.frame_score(3)).to eq 10
    end

  end

end