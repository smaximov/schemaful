# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      # String validation type.
      #
      # @example
      #   string = Schemaful::Schema::Type::String.new
      #   string.validate('42') #=> nil
      #   string.validate(42) #=> raise Schemaful::ValidationError
      #   # Restrict length
      #   string.validator(->(v) { v.size > 3 })
      #   string.validate('42') #=> raise Schemaful::ValidationError
      #   string.validate('test') #=> nil
      class String < Any
        type ::String
      end
    end
  end
end
