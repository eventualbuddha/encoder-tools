require File.dirname(__FILE__) + '/../spec_helper'

describe EncoderTools::Subtitles::List do
  before :all do
    @kill_bill = subfile('kill-bill-vol-2')
    @first_sub = subtitle(2716..2717.145, "Master...")
    @last_sub  = subtitle(4518..4520.300, "I - give - you - my - word...")
  end

  it "can load subtitles from a string" do
    list = described_class.load(@kill_bill).entries
    list.first.should == @first_sub
    list.last.should  == @last_sub
  end

  it "loads all the subtitles" do
    described_class.load(@kill_bill).should have(81).entries
  end

  it "has offset equal to the offset of the first subtitle" do
    described_class.load(@kill_bill).offset.should == 2716
  end

  context "with no subtitles" do
    subject { described_class.load("") }

    it "has offset 0" do
      subject.offset.should == 0
    end

    it "ignores setting the offset" do
      lambda { subject.offset += 2 }.
        should_not change { subject.offset }.from(0)
    end
  end

  it "allows adjusting the offsets of all subtitles by setting an offset" do
    list = described_class.load(@kill_bill)
    list.offset += 1
    list.entries.first.should == subtitle(2717..2718.145, "Master...")
    list.entries.last.should  == subtitle(4519..4521.300, "I - give - you - my - word...")
  end

  it "represents itself as a string suitable for use in a subtitle file" do
    subject.entries = [subtitle(0..1, "Hello World"), subtitle(1..2, "It's good to see you")]
    subject.to_s.should == <<-EOS
1
00:00:00,000 --> 00:00:01,000
Hello World

2
00:00:01,000 --> 00:00:02,000
It's good to see you

EOS
  end
end
