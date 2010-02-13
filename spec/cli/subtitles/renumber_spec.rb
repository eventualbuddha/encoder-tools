require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe EncoderTools::CLI::Subtitles::Renumber do
  subject { described_class.new(EncoderTools::CLI::Shell) }

  it "does nothing with an empty subtitle list" do
    stdin("") do
      stdout { subject.run }.should == ""
    end
  end

  it "does not alter a correctly-numbered subtitle list" do
    stdin(subfile("kill-bill-vol-2")) do
      stdout { subject.run }.should == subfile("kill-bill-vol-2")
    end
  end

  it "fixes bad numbering in a subtitle list" do
    stdin(subfile("bad-numbering")) do
      stdout { subject.run }.should == subfile("bad-numbering-corrected")
    end
  end
end
