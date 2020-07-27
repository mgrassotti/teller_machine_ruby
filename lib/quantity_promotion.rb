# frozen_string_literal: true

# Promotion on the number of bought pieces
class QuantityPromotion
  attr_reader :units, :price, :product_code
  def initialize(rule, products_codes)
    unless rule.is_a?(Hash) && rule[:units].to_i.positive? &&
           rule[:price].is_a?(Numeric) &&
           products_codes.include?(rule[:product_code])

      raise 'Invalid promotional rule input format: '\
        '\'{ :units, :price, :product_code }\' expected, '\
        "got '#{rule}'"
    end

    @units = rule[:units]
    @price = rule[:price]
    @product_code = rule[:product_code]
  end
end
