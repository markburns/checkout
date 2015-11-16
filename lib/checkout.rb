require "./lib/checkout_setup"

class Checkout < Struct.new(:promotional_rules)
  delegate :items, :sub_total, to: :basket

  def scan(item)
    items.push item
  end

  def total
    (sub_total_after_item_discounts - basket_discounts).round
  end

  def basket_discounts
    apply_rules(basket_discount_rules) do |r|
      r.discount(basket, sub_total_after_item_discounts)
    end
  end

  def item_discounts
    apply_rules(item_discount_rules) do |r|
      r.discount(basket)
    end
  end

  private

  def basket
    @basket ||= Basket.new
  end

  def apply_rules(rules)
    result = rules.map do |r|
      yield r
    end

    result.inject(&:+) || 0
  end

  def basket_discount_rules
    rule_type BasketDiscount
  end

  def item_discount_rules
    rule_type ItemDiscount
  end

  def rule_type(klass)
    promotional_rules
      .select { |r| r.is_a?(klass) }
  end

  def sub_total_after_item_discounts
    (sub_total - item_discounts)
  end
end
