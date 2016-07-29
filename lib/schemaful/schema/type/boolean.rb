# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      # Boolean validation type.
      #
      # @example
      #   bool = Schemaful::Schema::Type::Boolean.new
      #   bool.validate(true) #=> nil
      #   bool.validate(false) #=> nil
      #   bool.validate('true') #=> raise Schemaful::ValidationError
      class Boolean < Any
        type Schemaful::Boolean
      end
    end
  end
end
