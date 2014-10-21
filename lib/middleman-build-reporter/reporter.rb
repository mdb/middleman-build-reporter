require 'git'
require 'json'
require 'yaml'

module Middleman
  module BuildReporter
    class Reporter
      attr_accessor :app, :repo

      def initialize(app_instance, opts = nil)
        @app = app_instance

        @options = opts
        @repo = Git.open(opts.repo_root)
      end

      def write
        @options.reporter_file_formats.each do |format|
          file = "#{reporter_file_path}.#{format}"

          File.write(file, serialize(format))

          yield(file) if block_given?
        end
      end

      def reporter_file_path
        "#{@app.build_dir}/#{@options.reporter_file}"
      end

      def reporter_extension_file_path
        "#{@app.root}/.build_reporter.yml"
      end

      def details
        {
          'branch' => @repo.current_branch,
          'revision' => @repo.log.first.to_s,
          'build_time' => build_time.to_s,
          'version' => @options.version
        }.merge(details_extension)
      end

      def details_extension
        return {} unless details_extension_exist?

        YAML.load(File.read(reporter_extension_file_path))
      end

      def details_extension_exist?
        File.exist?(reporter_extension_file_path)
      end

      def build_time
        Time.now
      end

      def serialize(format)
        method = "to_#{format}".to_sym

        details.send(method)
      end
    end
  end
end
