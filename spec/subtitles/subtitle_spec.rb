require File.dirname(__FILE__) + '/../spec_helper'

describe EncoderTools::Subtitles::Subtitle do
  subject { described_class.new(1.5..2, "Hello World") }

  it "has a range" do
    subject.range.should == (1.5..2)
  end

  it "has text" do
    subject.text.should == "Hello World"
  end

  it "has offset equal to the start of the range" do
    subject.offset.should == 1.5
  end

  it "allows adjusting the range by setting the offset" do
    subject.offset = 2
    subject.range.should == (2..2.5)
  end

  it "represents itself as a string with the timestamp range and text" do
    subject.to_s.should == %{00:00:01,500 --> 00:00:02,000\nHello World}
  end

  it "allows adjusting the end of the range by setting the duration" do
    subject.duration = 2
    subject.range.should == (1.5..3.5)
  end
end
