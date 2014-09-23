require 'git'
require 'json'
require 'yaml'

module Middleman
  module BuildReporter
    class Reporter
      attr_accessor :app

      def initialize(app_instance)
        @app = app_instance

        @app.set :repo, Git.open(@app.repo_root)
      end

      def write
        @app.reporter_file_formats.each do |format|
          file = "#{reporter_file_path}.#{format}"

          File.write(file, serialize(format))

          yield(file) if block_given?
        end
      end

      def reporter_file_path
        "#{@app.build_dir}/#{@app.reporter_file}"
      end

      def details
        {
          'branch' => repo.current_branch,
          'revision' => repo.log.first.to_s,
          'build_time' => build_time.to_s,
          'version' => @app.version
        }
      end

      def build_time
        @build_time ||= Time.now
      end

      def repo
        @app.repo
      end

      def serialize(format)
        method = "to_#{format}".to_sym

        details.send(method)
      end
    end
  end
end
