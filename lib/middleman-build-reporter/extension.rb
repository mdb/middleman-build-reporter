module Middleman
  class BuildReporterExtension < Middleman::Extension
    option :repo_root, nil, 'repo root'
    option :version, '', 'app version'
    option :reporter_file, 'build', 'build report file name'
    option :reporter_file_formats, ['yaml'], 'an array of build report file formats'

    def initialize(app, options_hash = {}, &block)
      super

      @app = app

      @app.set :repo_root, (options.repo_root ? options.repo_root : app.root)
      @app.set :version, options.version
      @app.set :reporter_file, options.reporter_file
      @app.set :reporter_file_formats, options.reporter_file_formats
      @app.set :build_report, build_report
    end

    def after_build(builder)
      @app.build_report.write do |file|
        builder.say_status :create, file, :green
      end
    end

    helpers do
      class Middleman::Application
        def build_reporter_fingerprint
          [
            '<!--',
            'FINGERPRINT:',
            "#{config.build_report.details.to_yaml}",
            '--!>',
          ].join("\n")
        end
      end
    end

    private

    def build_report
      Middleman::BuildReporter::Reporter.new(@app)
    end
  end
end
