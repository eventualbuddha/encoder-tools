require File.dirname(__FILE__) + '/../spec_helper'

RSpec.describe EncoderTools::Subtitles::Subtitle do
  subject { described_class.new(1.5..2, "Hello World") }

  it "has a range" do
    expect(subject.range).to eq(1.5..2)
  end

  it "has text" do
    expect(subject.text).to eq("Hello World")
  end

  it "has offset equal to the start of the range" do
    expect(subject.offset).to eq(1.5)
  end

  it "allows adjusting the range by setting the offset" do
    subject.offset = 2
    expect(subject.range).to eq(2..2.5)
  end

  it "represents itself as a string with the timestamp range and text" do
    expect(subject.to_s).to eq(%{00:00:01,500 --> 00:00:02,000\nHello World})
  end

  it "allows adjusting the end of the range by setting the duration" do
    subject.duration = 2
    expect(subject.range).to eq(1.5..3.5)
  end
end
