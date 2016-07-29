# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      # Numeric validation type.
      class Numeric < Any
        type ::Numeric

        # A new instance of {Numeric}.
        #
        # @see Any#initialize
        #
        # @example Range validator
        #   numeric = Schemaful::Schema::Type::Numeric.new
        #   numeric.validate(42) #=> nil
        #   numeric.validate(-42) #=> nil
        #   numeric.validator(0..Float::INFINITY)
        #   numeric.validate(-42) #=> raise Schemaful::ValidationError
        #
        # @param validator [Object, Array<Object>]
        #   additional validators.
        def initialize(validator: nil)
          super
        end

        # Convert a validator to a callable and add it to
        # the list of validators.
        # @param validator [#call, Class, Symbol, Range]
        def validator(validator)
          callable = ->(v) { validator.include?(v) } if validator.is_a?(Range)
          super(callable)
        end
      end
    end
  end
end