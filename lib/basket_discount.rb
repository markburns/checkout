class BasketDiscount
  include Virtus.model

  attribute :discount_trigger, Integer
  attribute :discount_rate, Numeric

  def discount(basket, amount_to_discount_from)
    if basket.sub_total > discount_trigger
      amount_to_discount_from * discount_rate / 100.0
    else
      0
    end
  end
end
