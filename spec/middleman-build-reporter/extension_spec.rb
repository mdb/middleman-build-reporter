require 'spec_helper'

describe Middleman::BuildReporterExtension do

  subject(:extension) { described_class.new(app) }

  let(:app) { middleman_app('basic-app') }

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

    context 'its default reporter file formats' do

      let(:reporter_file_formats) { settings[:reporter_file_formats] }

      it 'they are json and yaml' do
        expect(reporter_file_formats.default).to eq ['yaml']
      end

      it 'has the correct description' do
        expect(reporter_file_formats.description).to eq 'an array of build report file formats'
      end
    end
  end

  describe '#after_build' do

    let(:builder) { double('builder', say_status: 'fake status') }

    let(:build_report) { double('build_report', write: 'fake_write_result') }

    it 'writes the build report to a file' do
      allow(app).to receive(:build_report).and_return build_report

      expect(extension.after_build(builder)).to eq 'fake_write_result'
    end
  end
end
