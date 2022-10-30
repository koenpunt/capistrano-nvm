# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'capistrano-nvm/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-nvm'
  spec.version       = CapistranoNvm::VERSION
  spec.authors       = ['Koen Punt']
  spec.email         = ['koen@koenpunt.nl']
  spec.description   = 'nvm support for Capistrano 3.x'
  spec.summary       = 'nvm support for Capistrano 3.x'
  spec.homepage      = 'https://github.com/koenpunt/capistrano-nvm'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '> 2.6'

  spec.add_dependency 'capistrano', '~> 3.1'

  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop', '~> 1.37.1'

  spec.metadata = { 'rubygems_mfa_required' => 'true' }
end
