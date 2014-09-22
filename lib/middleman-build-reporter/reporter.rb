require 'git'

module Middleman
  module BuildReporter
    class Reporter
      attr_accessor :app

      def initialize(app_instance)
        @app = app_instance

        @app.set :repo, Git.open(@app.repo_root)
      end

      def write
        File.write(reporter_file_path, details)
      end

      def reporter_file_path
        "#{@app.build_dir}/#{@app.reporter_file}"
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
