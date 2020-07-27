# frozen_string_literal: true

RSpec.describe TotalPromotion do
  context 'with an invalid rule input format' do
    let(:invalid_input_1) { { amount: 10.95 } }
    let(:invalid_input_2) { { amount: 'abc', discout_percentage: 0.1 } }

    it 'raises an exception' do
      [invalid_input_1, invalid_input_2].each do |input|
        expect { TotalPromotion.new(input) }.to(
          raise_error(TotalPromotion::InvalidRuleFormat)
        )
      end
    end
  end
end
