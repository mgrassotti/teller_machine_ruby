# frozen_string_literal: true

RSpec.describe PromotionsList do
  context 'with an invalid input' do
    let(:invalid_rules) do
      [
        { on: 'undefined', amount: 60, discount_percentage: 0.1 }
      ]
    end
    let(:invalid_rules_class) { 'string' }

    it 'raises an exception' do
      expect { PromotionsList.new(Checkout.new(invalid_rules), invalid_rules) }
        .to raise_error(PromotionsList::InvalidRuleTypeError)

      expect do
        PromotionsList.new  Checkout.new(invalid_rules_class),
                            invalid_rules_class
      end.to raise_error(RuntimeError)
    end
  end
end
