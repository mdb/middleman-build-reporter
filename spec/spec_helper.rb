require 'bundler/setup'

Bundler.require(:development)

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each { |f| require f }

SimpleCov.start

require 'middleman-build-reporter'
require 'middleman-build-reporter/extension'

def middleman_app(fixture_path)
  root_dir = File.expand_path("../../fixtures/#{fixture_path}", __FILE__)

  if File.exist?(File.join(root_dir, 'source'))
    ENV['MM_SOURCE'] = 'source'
  else
    ENV['MM_SOURCE'] = ''
  end

  initialize_commands = @initialize_commands || []

  initialize_commands.unshift lambda {
    set :root, root_dir
    set :environment, :development
    set :show_exceptions, false
  }

  Middleman::Application.server.inst do
    initialize_commands.each do |p|
      instance_exec(&p)
    end
  end
end
