module Middleman
  class BuildReporterExtension < Extension
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
    end

    def after_build(builder)
      build_report.write do |file|
        builder.say_status :create, file, :green
      end
    end

    def build_report
      @report ||= Middleman::BuildReporter::Reporter.new(@app)
    end
  end
end
