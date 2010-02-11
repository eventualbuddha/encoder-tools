require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EncoderTools::Encoders::Movie do
  subject { described_class.new("fixtures/Batman.dvdmedia") }

  it "has an input_path attribute reader" do
    subject.input_path.should == "fixtures/Batman.dvdmedia"
  end

  it "has a title attribute accessor defaulting to longest title" do
    subject.title.should == EncoderTools::Options::Title::LONGEST
  end

  it "accepts a number as a title and converts it to a Title option" do
    subject.title = 1
    subject.title.should == EncoderTools::Options::Title.new(1)
  end

  it "raises when setting an invalid title" do
    lambda { subject.title = 'foo' }.
      should raise_error(ArgumentError, %{expected an EncoderTools::Options::Title or Fixnum, got "foo"})
  end
end
