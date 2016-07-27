# frozen_string_literal: true

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec/collection_matchers'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'schemaful'
