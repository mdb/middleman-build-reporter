module Middleman
  class BuildReporterExtension < Extension
    def initialize(app, options_hash = {}, &block)
      super
    end

    def after_build(builder)
      report = Middleman::BuildReporter::Reporter.new(@app)

      report.write
    end
  end
end
