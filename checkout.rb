# frozen_string_literal: true

require 'yaml'
require_relative 'lib/promotions_list'

# Main application class
class Checkout
  class ProductNotFoundError < StandardError; end
  DEFAULT_PRODUCTS_PATH = './data/products.yml'

  attr_reader :products, :promotions
  attr_accessor :cart, :bill

  def initialize(promotional_rules = nil, products_path = nil)
    @products = YAML.safe_load(File.read(products_path || DEFAULT_PRODUCTS_PATH))
    @promotions = PromotionsList.new self, promotional_rules
    @bill = 0
    @cart = {}
  end

  def products_codes
    products.map { |p| p['code'] }
  end

  def scan(code)
    code && products_codes.include?(code) || raise(
      ProductNotFoundError, message: "Product code '#{code}' not found"
    )

    cart[code] ||= 0
    cart[code] += 1
  end

  def discounted_price_for(code, quantity)
    quantity_promotion = promotions.quantity_promotion_on(code, quantity)
    quantity_promotion ? quantity_promotion.price : find_product_price(code)
  end

  def find_product_price(code)
    products.select { |p| p['code'] == code }.first['price']
  end

  def total
    cart.each do |code, quantity|
      self.bill += discounted_price_for(code, quantity) * quantity
    end
    (bill - discount_on_total).round(2)
  end

  def discount_on_total
    promotions.total_discount_on(bill)
  end
end
