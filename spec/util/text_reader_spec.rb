require File.expand_path('../../spec_helper', __FILE__)

RSpec.describe EncoderTools::Util::TextReader do
  def file_for_textfile(name)
    described_class.new(File.open(textfile_path(name)))
  end

  def string_for_textfile(name)
    described_class.new(textfile(name))
  end

  it "reads a file from disk" do
    expect(file_for_textfile('no-encoding-marker').read).to eq("no encoding markers here\n")
  end

  it "reads a file stripping the encoding marker" do
    expect(file_for_textfile('encoding-marker').read).to eq("foo\n")
  end

  it "reads a string from memory" do
    expect(string_for_textfile('no-encoding-marker').read).to eq("no encoding markers here\n")
  end

  it "reads a string from memory stripping the encoding marker" do
    expect(string_for_textfile('encoding-marker').read).to eq("foo\n")
  end
end
