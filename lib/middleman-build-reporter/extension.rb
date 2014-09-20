module Middleman
  class BuildReporterExtension < Extension
    option :repo_root, nil, 'app root'
    option :version, '', 'app version'

    def initialize(app, options_hash = {}, &block)
      super

      app.set :repo_root, (options.repo_root ? options.repo_root : app.root)
      app.set :version, options.version
    end

    def after_build(builder)
      report = Middleman::BuildReporter::Reporter.new(@app)

      report.write
    end
  end
end
