# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      # This is a base class for all `Type`s. A `Type` class has an associated
      # Ruby type and is responsible for validation of values accorging to that
      # type.
      #
      # This class represents the "wildcard" type and accepts every value as
      # valid.
      #
      # Subclasses should implement {#on_validate} hook to provide custom
      # validation according to their type.
      class Any < Base
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
        #   any = Schemaful::Schema::Type::Any.new
        #   any.validate('any value, literally!') #=> nil
        #
        # @example Specify a validator using the keyword argument
        #   any = Schemaful::Schema::Type::Any.new(validator: Integer)
        #   any.validate(2) #=> nil
        #   any.validate('invalid') #=> raise Schemaful::ValidationError
        #
        # @example Specify a validator using {#validator}
        #   any = Schemaful::Schema::Type::Any.new
        #
        #   # Any accepts any value by default:
        #   any.validate('string') #=> nil
        #
        #   # check if a value is Integer:
        #   any.validator(Integer)
        #   any.validate('string') #=> raise Schemaful::ValidationError
        #   any.validate(1) #=> nil
        #
        #   # check if a value is even:
        #   any.validator(:even?)
        #   any.validate(1) #=> raise Schemaful::ValidationError
        #   any.validate(2) #=> nil
        #
        # @param validator [Object, Array<Object>]
        #   additional validators. See {#validator} for the list of
        #   acceptable validator types.
        def initialize(validator: nil)
          super()
          Array(validator).each { |v| validator(v) }
        end

        # @return [Array<#call>] an array of validator functions.
        def validators
          @validators ||= []
        end

        # Convert a validator to a callable and add it to
        # the list of validators.
        #
        # Acceptable validator types are:
        #
        # - `#call` - any callable which return true or false.
        # - `Class` - the value should be an instance of that class
        #    (with regard to inheritance).
        # - `Symbol` - converted to proc.
        # @param validator [#call, Class, Symbol]
        # @return [self]
        def validator(validator)
          validators << case validator
                        when Symbol then validator.to_proc
                        when Class then ->(v) { v.is_a?(validator) }
                        else validator
                        end
          self
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
        # Default implementation checks if a value is an instance of
        # {.type} (with regard to inheritance).
        #
        # @param value [Object] a value to validate.
        # @return [Boolean]
        def on_validate(value)
          value.is_a?(self.class.type)
        end
      end
    end
  end
end
