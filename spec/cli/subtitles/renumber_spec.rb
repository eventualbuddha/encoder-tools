require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe EncoderTools::CLI::Subtitles::Renumber do
  before do
    @input = StringIO.new
    @output = StringIO.new
  end

  subject do
    described_class.new(
      :input => @input,
      :output => @output
    )
  end

  it "does nothing with an empty subtitle list" do
    @input.string = ""
    subject.run
    @output.string.should == ""
  end

  it "does not alter a correctly-numbered subtitle list" do
    @input.string = subfile("kill-bill-vol-2")
    subject.run
    @output.string.should == subfile("kill-bill-vol-2")
  end

  it "fixes bad numbering in a subtitle list" do
    @input.string = subfile("bad-numbering")
    subject.run
    @output.string.should == subfile("bad-numbering-corrected")
  end
end
