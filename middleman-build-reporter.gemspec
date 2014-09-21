# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-build-reporter/version"

Gem::Specification.new do |s|
  s.name          = "middleman-build-reporter"
  s.version       = Middleman::BuildReporter::VERSION
  s.platform      = Gem::Platform::RUBY

  s.authors       = ["Mike Ball"]
  s.email         = ["mikedball@gmail.com"]
  s.homepage      = "https://github.com/mdb/build-reporter"
  s.summary       = %q{Report build time git details within your Middleman build}
  s.description   = %q{Report build time git details within your Middleman build}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'middleman-core'
  s.add_runtime_dependency 'git'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'timecop'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'fivemat'
end
