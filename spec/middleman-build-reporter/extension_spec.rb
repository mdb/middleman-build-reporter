require 'spec_helper'

describe Middleman::BuildReporterExtension do
  let(:app) { middleman_app('basic-app') }

  let(:extension) { described_class.new(app) }

  context 'its default options' do

    let(:settings) { extension.options.instance_variable_get('@settings') }

    context 'its default repo_root' do

      let(:repo_root) { settings[:repo_root] }

      it 'is nil' do
        expect(repo_root.default).to be_nil
      end

      it 'has the correct description' do
        expect(repo_root.description).to eq 'repo root'
      end
    end

    context 'its default version' do

      let(:version) { settings[:version] }

      it 'is an empty string' do
        expect(version.default).to eq ''
      end

      it 'has the correct description' do
        expect(version.description).to eq 'app version'
      end
    end

    context 'its default reporter file' do

      let(:reporter_file) { settings[:reporter_file] }

      it 'is "build"' do
        expect(reporter_file.default).to eq 'build'
      end

      it 'has the correct description' do
        expect(reporter_file.description).to eq 'build report file name'
      end
    end
  end

  describe '#build_report' do

    it 'returns a Middleman::BuildReporter::Reporter instance' do
      expect(extension.build_report.class).to eq Middleman::BuildReporter::Reporter
    end
  end

  describe '#after_build' do

    it 'writes the build report to a file' do
      allow(extension.build_report).to receive(:write).and_return 'fake_write_result'

      expect(extension.after_build).to eq 'fake_write_result'
    end
  end
end
