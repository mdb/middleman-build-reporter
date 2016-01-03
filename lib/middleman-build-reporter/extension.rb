module Middleman
  class BuildReporterExtension < Middleman::Extension
    option :repo_root, nil, 'repo root'
    option :version, '', 'app version'
    option :reporter_file, 'build', 'build report file name'
    option :reporter_file_formats, ['yaml'], 'an array of build report file formats'

    def initialize(app, options_hash = {}, &block)
      super

      @app = app
      @app.config[:build_report] = Middleman::BuildReporter::Reporter.new(@app, options)
    end

    def after_build(builder)
        builder.say_status :create, file, :green
      @app.config[:build_report].write do |file|
      end
    end

    helpers do
      class Middleman::Application
        def build_reporter_fingerprint
          [
            '<!--',
            'FINGERPRINT:',
            "#{config.build_report.details.to_yaml}",
            '-->',
          ].join("\n")
        end
      end
    end
  end
end
