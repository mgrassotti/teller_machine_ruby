# frozen_string_literal: true

RSpec.describe Checkout do
  let(:products_path) { 'spec/dummy/products.yml' }
  let(:promotional_rules) do
    [
      { on: 'total', amount: 60, discount_percentage: 0.1 },
      { on: 'quantity', units: 2, price: 8.5, product_code: '001' }
    ]
  end
  let(:valid_cart) do
    [
      { basket: %w[001 002 003], expected_total: 66.78 },
      { basket: %w[001 003 001], expected_total: 36.95 },
      { basket: %w[001 002 001 003], expected_total: 73.76 }
    ]
  end

  context 'with valid inputs' do
    it 'saves the promotions list' do
      co = Checkout.new(promotional_rules, products_path)
      expect(co.promotions.count).to eq(promotional_rules.count)
      expect(co.promotions[0].class).to eq(TotalPromotion)
      expect(co.promotions[1].class).to eq(QuantityPromotion)
    end

    it 'calculates the total correctly' do
      valid_cart.each do |input|
        co = Checkout.new(promotional_rules, products_path)
        input[:basket].each { |code| co.scan(code) }

        expect(co.total).to eq(input[:expected_total])
      end
    end
  end

  context 'providing a unexisting product code' do
    it 'raises an exception' do
      co = Checkout.new(promotional_rules, products_path)
      expect { %w[001 002 008].each { |code| co.scan(code) } }.to(
        raise_error(Checkout::ProductNotFoundError)
      )
    end
  end
end
