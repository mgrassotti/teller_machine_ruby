# frozen_string_literal: true

RSpec.describe QuantityPromotion do
  context 'with an invalid rule input format' do
    let(:invalid_input_1) { { amount: 10 } }
    let(:invalid_input_2) { { amount: 10, price: 'abc' } }

    it 'raises an exception' do
      [invalid_input_1, invalid_input_2].each do |input|
        expect { QuantityPromotion.new(input) }.to(
          raise_error(QuantityPromotion::InvalidRuleFormat)
        )
      end
    end
  end
end
