# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      describe String do
        describe '.type' do
          subject { described_class.type }
          it { is_expected.to be(::String) }
        end

        describe '#validate' do
          it 'accepts only string values' do
            expect { subject.validate('42') }.not_to raise_error
            expect { subject.validate(42) }.to raise_error(ValidationError)
          end
        end
      end
    end
  end
end
