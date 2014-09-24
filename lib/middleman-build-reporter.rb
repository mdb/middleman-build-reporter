require 'middleman-core'
require 'middleman-build-reporter/version'
require 'middleman-build-reporter/reporter'

::Middleman::Extensions.register(:build_reporter) do
  require 'middleman-build-reporter/extension'

  ::Middleman::BuildReporterExtension
end
