# frozen_string_literal: true

module Schemaful
  module Schema
    # Base class for all schema classes.
    #
    # @abstract Subclass and override {#validate} to implement
    #   a custom Base class.
    class Base
      # Check if a value is valid.
      # @param value [Object] the value to validate.
      # @raise [ValidationError] if the value is invalid.
      def validate(value)       # rubocop:disable Lint/UnusedMethodArgument
        raise NotImplementedError
      end
    end
  end
end
