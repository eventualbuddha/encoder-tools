require 'spec_helper'

describe EncoderTools::CLI::Subtitles::SpellCheck do
  include_context 'a CLI command'

  it "fixes words with l's that should be i's" do
    options[:dict] = 'spec/fixtures/bad-spelling.dict'
    input.string = subfile("bad-spelling")
    subject.run
    output.string.should == subfile("bad-spelling-made-better")
  end
end
