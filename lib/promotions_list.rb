# frozen_string_literal: true

# required to define delegators (def_delegators)
require 'forwardable'

require 'total_promotion'
require 'quantity_promotion'

# Stores the list of promotions
class PromotionsList
  extend Forwardable
  class InvalidRuleTypeError < StandardError; end

  attr_reader :checkout, :list
  def_delegators :list, :count, :[]

  def initialize(checkout, rules)
    @checkout = checkout
    unless rules.is_a?(Array)
      raise "Invalid class #{rules.class} for parameter \'rules\',"\
        'please provide an Array'
    end

    @list = rules.inject([]) do |mem, rule|
      mem << new_promotion(rule)
    end
  end

  def new_promotion(rule)
    case rule[:on].to_s
    when 'total'
      TotalPromotion.new rule
    when 'quantity'
      QuantityPromotion.new rule, checkout.products_codes
    else
      raise InvalidRuleTypeError,
            message: "Invalid :on value for the rule '#{rule}'. "\
              'It should be one of [\'total\', \'quantity\']'
    end
  end

  def quantity_promotion_on(code, quantity)
    list.select do |promotion|
      promotion.is_a?(QuantityPromotion) &&
        promotion.product_code == code &&
        promotion.units <= quantity
    end.first
  end

  def total_promotions_on(total_amount)
    list.select do |promotion|
      promotion.is_a?(TotalPromotion) &&
        promotion.amount <= total_amount
    end
  end

  def total_discount_on(bill)
    total_promotions_on(bill).inject(0) do |mem, promotion|
      mem + (promotion.discount_percentage * bill)
    end
  end
end
