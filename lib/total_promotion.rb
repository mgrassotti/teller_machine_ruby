# frozen_string_literal: true

# Promotion on the total spent amount
class TotalPromotion
  attr_reader :amount, :discount_percentage

  def initialize(rule)
    unless rule.is_a?(Hash) &&
           rule[:amount].is_a?(Numeric) && rule[:amount] >= 0 &&
           rule[:discount_percentage].is_a?(Numeric) &&
           rule[:discount_percentage] <= 1 && rule[:discount_percentage] >= 0

      raise 'Invalid promotional rule input format: '\
        '\'{ :amount, :discount_percentage }\' expected, '\
        "got '#{rule}'"
    end

    @amount = rule[:amount]
    @discount_percentage = rule[:discount_percentage]
  end
end
