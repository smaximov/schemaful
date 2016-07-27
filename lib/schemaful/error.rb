# frozen_string_literal: true

module Schemaful
  # Base error class for Schemaful.
  class Error < StandardError; end

  # Base error class for all schema-related errors.
  class SchemaError < Error; end

  class ValidationError < SchemaError; end

  class ParseError < SchemaError; end

  class SerializeError < SchemaError; end
end
