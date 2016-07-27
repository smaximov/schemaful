# frozen_string_literal: true

require 'spec_helper'

module Schemaful
  module Schema
    describe Base do
      describe'#validate' do
        it do
          expect { subject.validate(2) }.to raise_error(NotImplementedError)
        end
      end
    end
  end
end
