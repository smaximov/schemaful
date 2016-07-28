# frozen_string_literal: true

module Schemaful
  module Refine
    # Add `#to_proc` to Class.
    module ClassToProc
      # @!method to_proc
      #   Convert a class to a proc. This proc takes an argument
      #   and checks whether the class is the argument's class or
      #   its class's subclass.
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
