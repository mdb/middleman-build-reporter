require 'spec_helper'

describe Middleman::BuildReporterExtension do
  let(:extension) { described_class.new(app, {}) }

  describe '#after_build' do
    xit 'instantiates a Reporter and calls its #write method' do
      # TODO
    end
  end
end
