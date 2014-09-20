require 'git'

module Middleman
  module BuildReporter
    class Reporter
      def initialize(app_instance)
        @app = app_instance

        @repo = Git.open(@app.root)
      end

      def write
        File.write("#{@app.build_dir}/build", details)
      end

      def details
        [
          "branch: #{@repo.current_branch}",
          "revision: #{@repo.log.first.to_s}",
          "build_time: #{build_time.to_s}"
        ].join("\n")
      end

      def build_time
        @build_time ||= Time.now
      end
    end
  end
end
