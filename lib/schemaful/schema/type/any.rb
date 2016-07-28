# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      # This is a base class for all `Type`s. A `Type` class has an associated
      # Ruby type and is responsible for:
      #
      # - (*optional*) parsing a string representation of a value of
      #   the associated type;
      # - validating that value;
      # - (*optional*) converting a value of the associated type to String.
      #
      # This class represents the "wildcard" type and accepts every value as
      # valid.
      #
      # Subclasses should implement {#on_validate} hook to provide custom
      # validation according to their type.
      class Any < Base
        using Refine::ClassToProc

        # @return [Array<#to_proc>] array of validation functions.
        attr_reader :validators

        # @overload type
        #   @return [Class] the type associated with the class.
        # @overload type(value)
        #   Set the type associated with the class.
        #   @param value [Class] a type to be associated with the class.
        def self.type(value = nil)
          if value.nil?
            @type
          else
            @type = value
            nil
          end
        end

        # Make sure {.type} is inherited.
        # @!visibility private
        def self.inherited(subclass)
          subclass.type(type)
        end

        type Object

        # A new instance of Any.
        #
        # To restrict accepted values, you should provide additional validators
        # using the keyword parameter `validator:` or {#validator}.
        #
        # @example Basic usage
        #   any = Any.new
        #   any.validate('any value, literally!') #=> nil
        #
        # @example Specify a validator using the keyword argument
        #   any = Any.new(validator: ->(v) { v.is_a?(Integer) })
        #   any.validate(2) #=> nil
        #   any.validate('invalid') #=> raise Schemaful::ValidationError
        #
        # @example Specify a validator using {#validator}
        #   any = Any.new
        #
        #   # Any accepts any value by default:
        #   any.validate('string') #=> nil
        #
        #   # check if a value is Integer:
        #   any.validator(->(v) { v.is_a?(Integer) })
        #   any.validate('string') #=> raise Schemaful::ValidationError
        #   any.validate(1) #=> nil
        #
        #   # check if a value is even:
        #   any.validator(:even?)
        #   any.validate(1) #=> raise Schemaful::ValidationError
        #   any.validate(2) #=> nil
        #
        # @param validator [#to_proc, Array<#to_proc>]
        #   either a validation function or an array of validation functions.
        def initialize(validator: [])
          super()
          @validators = Array(validator)
        end

        # Add a validation function.
        #
        # @param validator [#to_proc]
        def validator(validator)
          @validators << validator
        end

        # Check if a value is valid.
        #
        # This method invokes (#on_validate) hook and each one of (#validators),
        # in order. If any of these validators return a false or nil, the
        # value is considered invalid, and {ValidationError} is raised.
        # @param value [Object] a value to validate.
        # @raise [ValidationError] if any validator failed.
        def validate(value)
          raise ValidationError unless on_validate(value)
          validators.each do |validator|
            raise ValidationError unless validator.to_proc.call(value)
          end
          nil
        end

        # Check if a value is valid.
        #
        # This is a hook which is meant to be overriden by subclasses.
        #
        # @param value [Object] a value to validate.
        # @return [Boolean]
        def on_validate(value)  # rubocop:disable Lint/UnusedMethodArgument
          true
        end
      end
    end
  end
end
