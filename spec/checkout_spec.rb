# frozen_string_literal: true

RSpec.describe Checkout do
  let(:products_path) { 'dummy/products.yml' }
  let(:promotional_rules) do
    [
      { on: :total, amount: 60, discount_percentage: 0.1 },
      { on: :price, units: 2, price: 8.5, product_code: '001' }
    ]
  end

  it 'calculates the total correctly' do
    [
      { basket: %w[001 002 003], expected_total: 66.78 },
      { basket: %w[001 003 001], expected_total: 36.95 },
      { basket: %w[001 002 001 003], expected_total: 73.76 }
    ].each do |basket, expected_total|
      co = Checkout.new(promotional_rules, products_path)
      basket.each { |code| co.scan(code) }

      expect(co.total).to eq(expected_total)
    end
  end
end
