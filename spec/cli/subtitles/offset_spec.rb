require File.expand_path('../../../spec_helper', __FILE__)

describe EncoderTools::CLI::Subtitles::Offset do
  it_should_behave_like 'a CLI command'

  it "does nothing with an empty subtitle list" do
    options[:offset] = '+0'
    input.string = ""
    subject.run
    output.string.should == ""
  end

  it "does not alter a subtitle list with zero offset" do
    options[:offset] = '+0'
    input.string = subfile("kill-bill-vol-2")
    subject.run
    output.string.should == subfile("kill-bill-vol-2")
  end

  it "writes a file with positive offset" do
    options[:offset] = '+2'
    input.string = subfile("short-example")
    subject.run
    output.string.should == subfile("short-example-offset-plus-2")
  end

  it "writes a file with negative offset" do
    options[:offset] = '-2'
    input.string = subfile("short-example")
    subject.run
    output.string.should == subfile("short-example-offset-minus-2")
  end

  it "writes a file with absolute offset" do
    options[:offset] = '2'
    input.string = subfile("short-example")
    subject.run
    output.string.should == subfile("short-example-offset-2")
  end
end
