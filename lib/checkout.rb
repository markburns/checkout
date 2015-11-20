require "./lib/checkout_setup"

class Checkout
  include Virtus.model

  attribute :promotional_rules, Array

  delegate :items, :sub_total, to: :basket

  def scan(item)
    items.push item
  end

  def total
    running_sub_total = sub_total

    promotional_rules.each do |r|
      discount = r.discount(items: items, running_sub_total: running_sub_total)

      running_sub_total = running_sub_total - discount
    end

    running_sub_total.round
  end

  private

  def basket
    @basket ||= Basket.new
  end
end
