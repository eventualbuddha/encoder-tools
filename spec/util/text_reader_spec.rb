require File.expand_path('../../spec_helper', __FILE__)

describe EncoderTools::Util::TextReader do
  def file_for_textfile(name)
    described_class.new(File.open(textfile_path(name)))
  end

  def string_for_textfile(name)
    described_class.new(textfile(name))
  end

  it "reads a file from disk" do
    file_for_textfile('no-encoding-marker').read.should == "no encoding markers here\n"
  end

  it "reads a file stripping the encoding marker" do
    file_for_textfile('encoding-marker').read.should == "foo\n"
  end

  it "reads a string from memory" do
    string_for_textfile('no-encoding-marker').read.should == "no encoding markers here\n"
  end

  it "reads a string from memory stripping the encoding marker" do
    string_for_textfile('encoding-marker').read.should == "foo\n"
  end
end
