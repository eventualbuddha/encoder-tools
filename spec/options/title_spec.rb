require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe EncoderTools::Options::Title do
  subject { described_class.new(1) }

  it "initializes with an integer as the title number" do
    expect(subject.number).to eq(1)
  end

  it "converts to Handbrake arguments" do
    expect(subject.to_args).to eq(%w[--title 1])
  end

  it "equals another Title with the same number" do
    expect(subject).to eq(described_class.new(1))
  end

  it "does not equal another Title with a different number" do
    expect(subject).not_to eq(described_class.new(2))
  end

  describe EncoderTools::Options::Title::LONGEST do
    subject { EncoderTools::Options::Title::LONGEST }

    it "is a Title" do
      expect(subject).to be_a(EncoderTools::Options::Title)
    end

    it "has no title number" do
      expect(subject.number).to eq(nil)
    end

    it "converts to Handbrake arguments" do
      expect(subject.to_args).to eq(%w[--longest])
    end

    it "does not equal a Title with a specific number" do
      expect(subject).not_to eq(EncoderTools::Options::Title.new(1))
    end
  end
end
