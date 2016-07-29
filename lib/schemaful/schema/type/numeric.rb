# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      # Numeric validation type.
      #
      # @example Range validator
      #   numeric = Schemaful::Schema::Type::Numeric.new
      #   numeric.validate(42) #=> nil
      #   numeric.validate(-42) #=> nil
      #   numeric.validator(0..Float::INFINITY)
      #   numeric.validate(-42) #=> raise Schemaful::ValidationError
      class Numeric < Any
        type ::Numeric

        # Convert a validator to a callable and add it to
        # the list of validators.
        #
        # In additional to the validators, introduced in
        # {Any#validator}, the following types are accepted:
        #
        # - `Range` - the value should lie in that range.
        # @param validator [#call, Class, Symbol, Range]
        # @return [self]
        def validator(validator)
          callable = ->(v) { validator.include?(v) } if validator.is_a?(Range)
          super(callable)
        end
      end
    end
  end
end
