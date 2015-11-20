class BasketDiscount < Discount
  attribute :discount_trigger, Integer
  attribute :discount_rate, Numeric

  def discount(items: nil, running_sub_total: )
    if running_sub_total > discount_trigger
      running_sub_total * discount_rate / 100.0
    else
      0
    end
  end
end
