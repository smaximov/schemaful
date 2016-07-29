# frozen_string_literal: true

require 'spec_helper'

module Schemaful
  module Schema
    module Type
      describe Any do
        describe '.type' do
          subject { described_class.type }
          it { is_expected.to be(Object) }
        end

        describe '#initialize' do
          subject { described_class.new(validator: validator) }

          context 'without validators' do
            let(:validator) { nil }

            it { is_expected.to have(0).validators }
          end

          context 'with a single validator' do
            let(:validator) { :even? }

            it { is_expected.to have(1).validators }
          end

          context 'with an array of validators' do
            let(:validator) { [Integer, :even?] }

            it { is_expected.to have(2).validators }
          end
        end

        describe '#validate' do
          subject { described_class.new(validator: validator) }

          context 'any value' do
            let(:validator) { nil }

            it 'should be valid' do
              expect { subject.validate('42') }.not_to raise_error
              expect { subject.validate(42) }.not_to raise_error
            end
          end

          context 'with a validator' do
            let(:validator) { String }

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

        context'subclass' do
          subject { Class.new(described_class, &body).new }
          let(:body) { proc {} }

          describe '.type' do
            it 'is inherited' do
              expect(subject.class.type).to be(Object)
            end
          end

          context 'with custom .type' do
            let(:body) do
              proc { type String }
            end

            describe '#on_validate' do
              it 'checks .type' do
                expect(subject.on_validate('42')).to be true
                expect(subject.on_validate(42)).to be false
              end
            end
          end

          context 'with custom #on_validate' do
            let(:body) do
              proc do
                def on_validate(value)
                  value.is_a?(Integer)
                end
              end
            end

            describe '#validate' do
              context 'valid value' do
                it { expect { subject.validate(42) }.not_to raise_error }
              end

              context 'invalid value' do
                it do
                  expect { subject.validate(42.0) }
                    .to raise_error(ValidationError)
                end
              end

              context 'with a validator' do
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
  end
end
