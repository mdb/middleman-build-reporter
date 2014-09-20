require 'spec_helper'

describe Middleman::BuildReporterExtension do
  let(:app) do
    double('app',
      root: 'app_root',
      build_dir: 'app_build_dir',
      initialized: 'fake_initialized'
    )
  end

  let(:reporter) do
    double('reporter',
      write: 'fake_write'
    )
  end

  let(:extension) { described_class.new(app, {}) }

  describe '#after_build' do
    it 'instantiates a Reporter and calls its #write method' do
      allow_any_instance_of(Middleman::BuildReporter::Reporter).to receive(:new).with(app).and_return(reporter)

      expect(extension.after_build).to eq 'fake_result'
    end
  end
end
