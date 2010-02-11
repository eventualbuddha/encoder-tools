require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EncoderTools::Options::Title do
  subject { described_class.new(1) }

  it "initializes with an integer as the title number" do
    subject.number.should == 1
  end

  it "converts to Handbrake arguments" do
    subject.to_args.should == %w[--title 1]
  end

  it "equals another Title with the same number" do
    subject.should == described_class.new(1)
  end

  it "does not equal another Title with a different number" do
    subject.should_not == described_class.new(2)
  end

  describe EncoderTools::Options::Title::LONGEST do
    subject { EncoderTools::Options::Title::LONGEST }

    it "is a Title" do
      subject.should be_a(EncoderTools::Options::Title)
    end

    it "has no title number" do
      subject.number.should == nil
    end

    it "converts to Handbrake arguments" do
      subject.to_args.should == %w[--longest]
    end

    it "does not equal a Title with a specific number" do
      subject.should_not == described_class.new(1)
    end
  end
end
