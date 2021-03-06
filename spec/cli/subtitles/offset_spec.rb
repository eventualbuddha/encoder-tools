require 'spec_helper'

RSpec.describe EncoderTools::CLI::Subtitles::Offset do
  include_context 'a CLI command'

  it "does nothing with an empty subtitle list" do
    options[:add] = '0'
    input.string = ""
    subject.run
    expect(output.string).to eq("")
  end

  it "does not alter a subtitle list with zero offset" do
    options[:add] = '0'
    input.string = subfile("kill-bill-vol-2")
    subject.run
    expect(output.string).to eq(subfile("kill-bill-vol-2"))
  end

  it "writes a file with positive offset" do
    options[:add] = '2'
    input.string = subfile("short-example")
    subject.run
    expect(output.string).to eq(subfile("short-example-offset-plus-2"))
  end

  it "writes a file with negative offset" do
    options[:subtract] = '2'
    input.string = subfile("short-example")
    subject.run
    expect(output.string).to eq(subfile("short-example-offset-minus-2"))
  end

  it "writes a file with absolute offset" do
    options[:set] = '2'
    input.string = subfile("short-example")
    subject.run
    expect(output.string).to eq(subfile("short-example-offset-2"))
  end

  it "parses an offset with a fractional part" do
    options[:set] = '12.34'
    expect(subject.send(:parse_offset, EncoderTools::Subtitles::List.new, options[:set])).to eq(BigDecimal(options[:set]))
  end

  it "parses an offset in hh:mm:ss format" do
    options[:set] = '1:02:03'
    expect(subject.send(:parse_offset, EncoderTools::Subtitles::List.new, options[:set])).to eq(3+(2+1*60)*60)
  end

  it "parses an offset in mm:ss format" do
    options[:set] = '2:03'
    expect(subject.send(:parse_offset, EncoderTools::Subtitles::List.new, options[:set])).to eq(3+2*60)
  end
end
