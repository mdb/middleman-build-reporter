require 'bundler/setup'
require 'git'

Bundler.require(:development)

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

SimpleCov.start

require 'middleman-build-reporter'
require 'middleman-build-reporter/extension'
