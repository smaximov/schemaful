# frozen_string_literal: true

module Schemaful
  # A hack to introduce a common superclass for TrueClass and FalseClass.
  module Boolean
  end
end

TrueClass.include(Schemaful::Boolean)
FalseClass.include(Schemaful::Boolean)
