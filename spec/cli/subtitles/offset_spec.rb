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

  it "parses an offset with a fractional part" do
    options[:offset] = '12.34'
    subject.send(:parse_offset, EncoderTools::Subtitles::List.new, options[:offset]).should == BigDecimal(options[:offset])
  end

  it "parses an offset in hh:mm:ss format" do
    options[:offset] = '1:02:03'
    subject.send(:parse_offset, EncoderTools::Subtitles::List.new, options[:offset]).should == 3+(2+1*60)*60
  end

  it "parses an offset in mm:ss format" do
    options[:offset] = '2:03'
    subject.send(:parse_offset, EncoderTools::Subtitles::List.new, options[:offset]).should == 3+2*60
  end
end
