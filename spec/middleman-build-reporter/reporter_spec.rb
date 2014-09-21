require 'spec_helper'

describe Middleman::BuildReporter::Reporter do

  let(:git_repo) { Git.open('.') }

  let(:app) { middleman_app('basic-app') }

  let(:reporter) do
    app.set :repo_root, '.'
    app.set :version, '1.2.3'

    described_class.new app
  end

  describe '#new' do

    it 'sets an attr_accessor\'d @app instance variable to the value of the app it is passed' do
      expect(reporter.app).to eq app
    end

    it 'sets a #repo on the app instance it is passed' do
      expect(reporter.app.repo.class).to eq Git::Base
    end
  end

  describe '#write' do

    it 'writes the build details to the proper "build" file' do
      allow(reporter).to receive(:details).and_return 'fake_details'
      allow(reporter).to receive(:report_file).and_return 'fake_report_file'

      allow(File).to receive(:write).with('fake_report_file', 'fake_details').and_return 'fake_write_call'

      expect(reporter.write).to eq 'fake_write_call'
    end
  end

  describe '#report_file' do

    it 'returns the file path to which the build details should be written' do
      expect(reporter.report_file).to eq "#{app.build_dir}/build"
    end
  end

  describe '#details' do

    before do
      Timecop.travel Time.now
    end

    after do
      Timecop.return
    end

    let(:details) { reporter.details.split("\n") }

    context 'the build details string it returns' do

      it 'reports the git branch' do
        expect(details[0]).to eq "branch: #{git_repo.current_branch}"
      end

      it 'reports the git revision' do
        expect(details[1]).to eq "revision: #{git_repo.log.first.to_s}"
      end

      it 'reports the build time' do
        expect(details[2]).to eq "build_time: #{Time.now.to_s}"
      end

      it 'reports the app version' do
        expect(details[3]).to eq "version: #{app.version}"
      end
    end
  end

  describe '#build_time' do

    it 'reports the current time' do
      expect(reporter.build_time.strftime('%Y-%m-%d %H:%M')).to eq Time.now.strftime('%Y-%m-%d %H:%M')
    end

    context 'when build time is already set' do
      it 'returns the existing value' do
        reporter.instance_variable_set('@build_time', 'foo')

        expect(reporter.build_time).to eq 'foo'
      end
    end
  end

  describe '#repo' do

    it 'is a shortcut to app#repo' do
      expect(reporter.repo).to eq app.repo
    end
  end
end
