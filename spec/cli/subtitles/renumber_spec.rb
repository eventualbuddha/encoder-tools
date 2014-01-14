require 'spec_helper'

describe EncoderTools::CLI::Subtitles::Renumber do
  include_context 'a CLI command'

  it "does nothing with an empty subtitle list" do
    input.string = ""
    subject.run
    output.string.should == ""
  end

  it "does not alter a correctly-numbered subtitle list" do
    input.string = subfile("kill-bill-vol-2")
    subject.run
    output.string.should == subfile("kill-bill-vol-2")
  end

  it "fixes bad numbering in a subtitle list" do
    input.string = subfile("bad-numbering")
    subject.run
    output.string.should == subfile("bad-numbering-corrected")
  end
end
