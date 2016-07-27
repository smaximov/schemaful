# frozen_string_literal: true

require 'spec_helper'

module Schemaful
  module Schema
    module Type
      describe Any do
        describe '.type' do
          subject { Any.type }
          it { is_expected.to be(Object) }
        end

        describe '#initialize' do
          subject { Any.new(validator: validator) }

          context 'without validators' do
            let(:validator) { [] }

            it { is_expected.to have(0).validators }
          end

          context 'single validator' do
            let(:validator) { :even? }

            it { is_expected.to have(1).validators }
          end

          context 'array of validators' do
            let(:validator) { [->(v) { v.is_a?(Integer) }, :even?] }

            it { is_expected.to have(2).validators }
          end
        end

        describe '#validate' do
          subject { Any.new(validator: validator) }

          context 'any value' do
            let(:validator) { [] }

            it 'should be valid' do
              expect { subject.validate('42') }.not_to raise_error
              expect { subject.validate(42) }.not_to raise_error
            end
          end

          context 'with a validator' do
            let(:validator) { ->(v) { v.is_a?(String) } }

            context 'valid value' do
              it { expect { subject.validate('42') }.not_to raise_error }
            end

            context 'invalid value' do
              it do
                expect { subject.validate(42) }.to raise_error(ValidationError)
              end
            end
          end
        end

        describe 'subclass' do
          let(:klass) do
            Class.new(Any) do
              def on_validate(value)
                value.is_a?(Integer)
              end
            end
          end
          subject { klass.new }

          context '#on_validate' do
            context 'valid value' do
              it { expect { subject.validate(42) }.not_to raise_error }
            end

            context 'invalid value' do
              it do
                expect { subject.validate(42.0) }
                  .to raise_error(ValidationError)
              end
            end
          end

          context '#on_validate with a validator' do
            before { subject.validator(:even?) }

            context 'valid value' do
              it { expect { subject.validate(42) }.not_to raise_error }
            end

            context 'invalid value' do
              it do
                expect { subject.validate(1) }
                  .to raise_error(ValidationError)
              end
            end
          end
        end
      end
    end
  end
end
