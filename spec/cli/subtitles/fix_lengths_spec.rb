require File.expand_path('../../../spec_helper', __FILE__)

describe EncoderTools::CLI::Subtitles::FixLengths do
  it_should_behave_like 'a CLI command'
  before { stub_shell! }

  context "with no subtitle lengths over the threshold" do
    before { input.string = subfile('no-long-subtitles') }

    it "says that there are no subtitles over the threshold" do
      shell.should_receive(:say).with("No subtitles found over #{described_class::THRESHOLD}s")
      subject.run
    end
  end

  context "with some subtitle lengths over the threshold" do
    before { input.string = subfile('some-long-subtitles') }

    it "asks whether the user wants to fix the long subtitles" do
      shell.should_receive(:yes?).with("Found 2 long subtitles. Would you like to fix them?").and_return(false)
      subject.run
    end

    it "asks for each subtitle how long it should be" do
      shell.should_receive(:yes?).and_return(true)
      shell.should_receive(:say).with(<<-TEXT)
00:45:21,373 --> 01:45:22,681 (3601s)
It causes my ears discomfort.

TEXT
      shell.should_receive(:say).with(<<-TEXT)
01:45:22,748 --> 02:45:24,274 (3601s)
You bray like an ass!

TEXT
      shell.should_receive(:ask).
        with("How long should it be?").
        twice.
        and_return('2')
      subject.run
    end

    it "writes the adjusted subtitles" do
      shell.should_receive(:yes?).and_return(true)
      shell.should_receive(:say).twice
      shell.should_receive(:ask).twice.and_return('2')
      subject.run
      output.string.should == subfile('adjusted-long-subtitles')
    end

    it "exits cleanly when interrupted" do
      shell.stub!(:yes?).and_return(true)
      shell.stub!(:say)
      shell.should_receive(:ask).and_raise(Interrupt)
      lambda { subject.run }.should_not raise_error
    end
  end
end
