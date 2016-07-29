# frozen_string_literal: true

module Schemaful
  module Refine
    # Add `#to_proc` to Range.
    module RangeToProc
      # @!method to_proc
      #   Convert a range to a proc which checks whether its argument
      #   lies inside the range.
      #
      #   @example
      #     module BoundedRange
      #       using Schemaful::Refine::RangeToProc
      #       (0..100).to_proc.call(42)
      #     end #=> true
      #
      #     module UnboundedRange
      #       using Schemaful::Refine::RangeToProc
      #       (-Float::INFINITY..Float::INFINITY).to_proc.call(42)
      #     end #=> true
      #
      #   @return [Proc]
      refine Range do
        def to_proc
          ->(v) { include?(v) }
        end
      end
    end
  end
end
