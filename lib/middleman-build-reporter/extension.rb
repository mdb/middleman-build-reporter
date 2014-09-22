module Middleman
  class BuildReporterExtension < Extension
    option :repo_root, nil, 'repo root'
    option :version, '', 'app version'
    option :reporter_file, 'build', 'build report file name'

    def initialize(app, options_hash = {}, &block)
      super

      @app = app

      @app.set :repo_root, (options.repo_root ? options.repo_root : app.root)
      @app.set :version, options.version
      @app.set :reporter_file, options.reporter_file
    end

    def after_build
      build_report.write
    end

    def build_report
      @report ||= Middleman::BuildReporter::Reporter.new(@app)
    end
  end
end
