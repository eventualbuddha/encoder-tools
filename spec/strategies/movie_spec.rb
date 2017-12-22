require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe EncoderTools::Strategies::Movie do
  subject { described_class.new("fixtures/Batman.dvdmedia") }

  it "has an input_path attribute reader" do
    expect(subject.input_path).to eq("fixtures/Batman.dvdmedia")
  end

  it "has a title attribute accessor defaulting to longest title" do
    expect(subject.title).to eq(EncoderTools::Options::Title::LONGEST)
  end

  it "accepts a number as a title and converts it to a Title option" do
    subject.title = 1
    expect(subject.title).to eq(EncoderTools::Options::Title.new(1))
  end

  it "raises when setting an invalid title" do
    expect { subject.title = 'foo' }.
      to raise_error(ArgumentError, %{expected an EncoderTools::Options::Title or Fixnum, got "foo"})
  end
end
