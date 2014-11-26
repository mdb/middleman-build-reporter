require 'spec_helper'

describe Middleman::BuildReporter::Reporter do

  subject(:reporter) do
    described_class.new app, options
  end

  let(:git_repo) { Git.open('.') }

  let(:fake_details) { { 'foo' => 'bar' } }

  let(:options) do
    double('options', {
      repo_root: '.',
      version: '1.2.3',
      reporter_file: 'reporter_file',
      reporter_file_formats: ['yaml']
    })
  end

  let(:app) { middleman_app('basic-app') }

  describe '#new' do

    it 'sets an attr_accessor\'d @app instance variable to the value of the app it is passed' do
      expect(reporter.app).to eq app
    end

    it 'sets the repo root' do
      expect(reporter.repo.dir.path).to eq(Dir.pwd)
    end

    context 'when a repo root is not specified' do
      let(:options) do
        double('options', { repo_root: nil })
      end

      it 'sets repo root to the current directory' do
        expect(reporter.repo.dir.path).to eq(Dir.pwd)
      end
    end
  end

  describe '#write' do

    it 'writes the build details to the proper "build" file' do
      allow(reporter).to receive(:details).and_return fake_details

      expect(File).to receive(:write).with('build/reporter_file.yaml', "---\nfoo: bar\n").and_return 'fake_write_call'

      reporter.write
    end
  end

  describe '#reporter_file_path' do

    it 'returns the file path to which the build details should be written' do
      expect(reporter.reporter_file_path).to eq 'build/reporter_file'
    end
  end

  describe '#reporter_extension_path' do

    it 'returns the file path to ".build_reporter.yml" file' do
      expect(reporter.reporter_extension_file_path).to eq "#{app.root}/.build_reporter.yml"
    end
  end

  describe '#details' do

    before do
      Timecop.travel Time.now
    end

    after do
      Timecop.return
    end

    let(:details) { reporter.details }

    context 'the build details hash it returns' do

      it 'reports the git branch' do
        expect(details['branch']).to eq "#{git_repo.current_branch}"
      end

      it 'reports the git revision' do
        expect(details['revision']).to eq "#{git_repo.log.first}"
      end

      it 'reports the build time' do
        expect(details['build_time']).to eq "#{Time.now}"
      end

      it 'reports the app version' do
        expect(details['version']).to eq '1.2.3'
      end

      context 'when there is a custom details extension' do
        before do
          allow(reporter).to receive(:details_extension).and_return 'foo' => 'bar'
        end

        it 'includes the additional details in the hash it returns' do
          expect(details['foo']).to eq 'bar'
        end
      end
    end
  end

  describe '#details_extension' do

    context 'when there is no ".build_reporter.yml" file in the root of the project' do

      it 'returns an empty hash' do
        expect(reporter.details_extension).to eq({})
      end
    end

    context 'when there is a ".build_reporter.yml" file in the root of the project' do

      it 'returns a hash representation of its YAML' do
        allow(reporter).to receive(:details_extension_exist?).and_return true
        allow(File).to receive(:read).with("#{app.root}/.build_reporter.yml").and_return "---\nsome_key: 'some value'\n"

        expect(reporter.details_extension).to eq('some_key' => 'some value')
      end
    end
  end

  describe '#details_extension_exist?' do

    context 'when there is no ".build_reporter.yml" in the project root' do

      it 'returns false' do
        expect(reporter.details_extension_exist?).to eq false
      end
    end

    context 'when there is a ".build_reporter.yml" in the project root' do

      it 'returns true' do
        allow(File).to receive(:exist?).with(reporter.reporter_extension_file_path).and_return true

        expect(reporter.details_extension_exist?).to eq true
      end
    end
  end

  describe '#build_time' do

    it 'reports the current time' do
      expect(reporter.build_time.strftime('%Y-%m-%d %H:%M')).to eq Time.now.strftime('%Y-%m-%d %H:%M')
    end
  end

  describe '#serialize' do

    before do
      allow(reporter).to receive(:details).and_return fake_details
    end

    context 'when it is passed "json"' do

      let(:json) { JSON.parse(reporter.serialize('json')) }

      it 'returns the build details as a JSON object' do
        expect(json['foo']).to eq 'bar'
      end
    end

    context 'when it is passed "yaml"' do

      let(:yaml) { YAML.load(reporter.serialize('yaml')) }

      it 'returns the build details as a JSON object' do
        expect(yaml['foo']).to eq 'bar'
      end
    end
  end
end
