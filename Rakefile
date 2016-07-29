# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'yard-doctest'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new
YARD::Rake::YardocTask.new(:yard)
YARD::Doctest::RakeTask.new

desc 'Run all tests'
task test: %i(spec yard:doctest)

task default: :test
