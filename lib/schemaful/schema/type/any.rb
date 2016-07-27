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
      # - (*optional*) converting a value of the associated type to {String}.
      #
      # This class represents the "wildcard" type and accepts every value as
      # valid.
      #
      # Subclasses should implement {#on_validate} hook to provide custom
      # validation according to their type.
      class Any < Base
        # @return [Array<#call, Symbol>] array of validation functions.
        attr_reader :validators

        # @overload type
        #   @return [Object] the type associated with the class.
        # @overload type(value)
        #   Set the type associated with the class.
        #   @param value [Object] a type to be associated with the class.
        def self.type(value = nil)
          if value.nil?
            @type
          else
            @type = value
            nil
          end
        end

        type Object

        # @param validators [Array<#call, Symbol>]
        #   array of validation functions.
        def initialize(validators: [])
          super()
          @validators = validators
        end

        # Add a validation function.
        #
        # @param validator [#call, Symbol]
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