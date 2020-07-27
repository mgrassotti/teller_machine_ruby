# frozen_string_literal: true

require 'yaml'
require_relative 'lib/promotions_list'

# Main application class
class Checkout
  DEFAULT_PRODUCTS_PATH = './data/products.yml'

  attr_reader :products, :promotions

  def initialize(promotional_rules = nil, products_path = nil)
    @products = YAML.safe_load(File.read(products_path || DEFAULT_PRODUCTS_PATH))
    @promotions = PromotionsList.new self, promotional_rules
  end

  def products_codes
    products.map { |p| p['code'] }
  end
end
