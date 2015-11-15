module Noths
  class BasketDiscount < Struct.new(:discount_trigger, :discount_rate)
    def discount(basket, amount_to_discount_from)
      if basket.sub_total > discount_trigger
        amount_to_discount_from * discount_rate / 100.0
      else
        0
      end
    end
  end
end
