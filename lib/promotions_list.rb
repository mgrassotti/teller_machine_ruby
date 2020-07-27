# frozen_string_literal: true

# required to define delegators (def_delegators)
require 'forwardable'

require 'total_promotion'
require 'quantity_promotion'

# Stores the list of promotions
class PromotionsList
  extend Forwardable

  attr_reader :checkout, :list
  def_delegators :list, :count, :[]

  def initialize(checkout, rules)
    @checkout = checkout
    rules.is_a?(Array) || raise('Invalid parameter \'rules\', please provide an Array')

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
      raise "Invalid :on value for the rule '#{rule}'. "\
        'It should be one of [\'total\', \'quantity\']'
    end
  end
end
