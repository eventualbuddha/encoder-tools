require 'spec_helper'

RSpec.describe EncoderTools::CLI::Subtitles::FixLengths do
  include_context 'a CLI command'

  context "with no subtitle lengths over the default threshold" do
    before { input.string = subfile('no-long-subtitles') }

    it "says that there are no subtitles over the threshold" do
      expect(shell).to receive(:say).with("No subtitles found over #{described_class::DEFAULT_THRESHOLD}s")
      subject.run
    end
  end

  context "with some subtitle lengths over the default threshold" do
    before { input.string = subfile('some-long-subtitles') }

    it "asks whether the user wants to fix the long subtitles" do
      expect(shell).to receive(:yes?).with("Found 2 long subtitles. Would you like to fix them?").and_return(false)
      subject.run
    end

    it "asks for each subtitle how long it should be" do
      expect(shell).to receive(:yes?).and_return(true)
      expect(shell).to receive(:say).with(<<-TEXT)
00:45:21,373 --> 01:45:22,681 (01:00:01,308)
It causes my ears discomfort.

TEXT
      expect(shell).to receive(:say).with(<<-TEXT)
01:45:22,748 --> 02:45:24,274 (01:00:01,526)
You bray like an ass!

TEXT
      expect(shell).to receive(:ask).
        with("How long should it be?").
        twice.
        and_return('2')
      subject.run
    end

    it "writes the adjusted subtitles" do
      expect(shell).to receive(:yes?).and_return(true)
      expect(shell).to receive(:say).twice
      expect(shell).to receive(:ask).twice.and_return('2')
      subject.run
      expect(output.string).to eq(subfile('adjusted-long-subtitles'))
    end

    it "exits cleanly when interrupted" do
      allow(shell).to receive(:yes?).and_return(true)
      allow(shell).to receive(:say)
      expect(shell).to receive(:ask).and_raise(Interrupt)
      expect { subject.run }.not_to raise_error
    end

    context "with a sufficiently high threshold" do
      before { options[:threshold] = 10_000 }

      it "says that there are no subtitles over the threshold" do
        expect(shell).to receive(:say).with("No subtitles found over 10000s")
        subject.run
      end
    end
  end
end
