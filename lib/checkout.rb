require "./lib/checkout_setup"

class Checkout
  include Virtus.model

  attribute :promotional_rules, Array

  def scan(item)
    items.push item
  end

  def total
    running_sub_total = sub_total

    promotional_rules.each do |r|
      running_sub_total = r.apply(items: items, running_sub_total: running_sub_total)
    end

    running_sub_total.round
  end

  def items
    @items ||= []
  end

  private

  def sub_total
    items.map(&:price).inject(&:+) || 0
  end
end
