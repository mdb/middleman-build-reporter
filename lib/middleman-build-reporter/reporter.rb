require 'git'

module Middleman
  module BuildReporter
    class Reporter
      def initialize(app_instance)
        @app = app_instance

        @app.set :repo, Git.open(@app.repo_root)
      end

      def write
        File.write("#{@app.build_dir}/build", details)
      end

      def details
        [
          "branch: #{repo.current_branch}",
          "revision: #{repo.log.first.to_s}",
          "build_time: #{build_time.to_s}",
          "version: #{@app.version}"
        ].join("\n")
      end

      def build_time
        @build_time ||= Time.now
      end

      def repo
        @app.repo
      end
    end
  end
end
