# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      describe Numeric do
        describe '.type' do
          subject { described_class.type }
          it { is_expected.to be(::Numeric) }
        end

        describe '#validate' do
          it 'accepts only numeric values ' do
            expect { subject.validate(42.0) }
            expect { subject.validate('42') }.to raise_error(ValidationError)
          end

          context 'with a range validator' do
            before { subject.validator(0..Float::INFINITY) }

            it 'accepts only values from the range' do
              expect { subject.validate(42) }.not_to raise_error
              expect { subject.validate(-1) }.to raise_error(ValidationError)
            end
          end
        end
      end
    end
  end
end
