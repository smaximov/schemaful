# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yard'
require 'yard-doctest'

RSpec::Core::RakeTask.new(:spec)

YARD::Rake::YardocTask.new(:yard)
YARD::Doctest::RakeTask.new

task default: :spec
