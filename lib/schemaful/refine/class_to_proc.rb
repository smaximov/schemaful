# frozen_string_literal: true

module Schemaful
  module Refine
    # Add `#to_proc` to Class.
    module ClassToProc
      # @!method to_proc
      #   Convert a class to a proc which tests whether
      #   its argument is an instance of the class (with
      #   regard to inheritance).
      #
      #   @example
      #     module Truthy
      #       using Schemaful::Refine::ClassToProc
      #       String.to_proc.call('42')
      #     end #=> true
      #
      #     module Falsy
      #       using Schemaful::Refine::ClassToProc
      #       String.to_proc.call(42)
      #     end #=> false
      #
      #   @example Inheritance
      #     module Subclass
      #       using Schemaful::Refine::ClassToProc
      #       MyString = Class.new(String)
      #       MyString.to_proc.call('42')
      #     end #=> true
      #
      #   @return [Proc]
      refine Class do
        def to_proc
          ->(v) { ancestors.include?(v.class) }
        end
      end
    end
  end
end
