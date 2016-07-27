# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schemaful/version'

Gem::Specification.new do |spec|
  spec.name = 'schemaful'
  spec.version = Schemaful::VERSION
  spec.authors = ['Sergei Maximov']
  spec.email = ['s.b.maximov@gmail.com']

  spec.summary = 'General-purpose configuration described by a flexible schema'
  spec.description = <<-DESC.gsub(/^\s+\| /, '')
    | A general-purpose configuration library with config validation support.
    | Validation is done by specifying a schema using convenient DSL.
  DESC
  spec.homepage = 'https://github.com/smaximov/schemaful'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 2.0.0'

  raise 'RubyGems 2.0 or newer is required.' unless spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = 'https://gems.maximov.space'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 11.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-doc'
end
