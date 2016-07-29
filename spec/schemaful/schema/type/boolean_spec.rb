# frozen_string_literal: true

module Schemaful
  module Schema
    module Type
      describe Boolean do
        describe '.type' do
          subject { described_class.type }
          it { is_expected.to be(Schemaful::Boolean) }
        end

        describe '#validate' do
          it 'accepts only boolean values' do
            expect { subject.validate(true) }.not_to raise_error
            expect { subject.validate(false) }.not_to raise_error
            expect { subject.validate(nil) }.to raise_error(ValidationError)
          end
        end
      end
    end
  end
end
