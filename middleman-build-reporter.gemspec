# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-build-reporter/version'

Gem::Specification.new do |s|
  s.name          = 'middleman-build-reporter'
  s.version       = Middleman::BuildReporter::VERSION
  s.platform      = Gem::Platform::RUBY

  s.authors       = ['Mike Ball']
  s.email         = ['mikedball@gmail.com']
  s.homepage      = 'https://github.com/mdb/middleman-build-reporter'
  s.summary       = %q{Report build time details within your Middleman build}
  s.description   = %q{Report build time details within your Middleman build}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'middleman-core', '>= 3.0.0'
  s.add_runtime_dependency 'git', '1.2.8'

  s.add_development_dependency 'rspec', '3.1.0'
  s.add_development_dependency 'simplecov', '0.9.0'
  s.add_development_dependency 'timecop', '0.7.1'
  s.add_development_dependency 'cucumber', '1.3.17'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'fivemat', '1.3.1'
  s.add_development_dependency 'rake', '10.3.2'
  s.add_development_dependency 'middleman'
end
