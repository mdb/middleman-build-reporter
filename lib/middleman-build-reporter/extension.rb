module Middleman
  class BuildReporterExtension < Extension
    option :repo_root, nil, 'repo root'
    option :version, '', 'app version'

    def initialize(app, options_hash = {}, &block)
      super

      @app = app

      @app.set :repo_root, (options.repo_root ? options.repo_root : app.root)
      @app.set :version, options.version
    end

    def after_build
      build_report.write
    end

    def build_report
      @report ||= Middleman::BuildReporter::Reporter.new(@app)
    end
  end
end
