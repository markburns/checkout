class ItemDiscount
  include Virtus.model

  attribute :discount_trigger, Integer
  attribute :discounted_value, Integer
  attribute :product_code,     String

  def discount(basket)
    discountable = relevant_items(basket.items)

    if discountable.count >= discount_trigger
      normal_price = discountable.map(&:price).inject(&:+)

      normal_price - discountable.count * discounted_value
    else
      0
    end
  end

  private

  def relevant_items(items)
    items.select { |i| i.product_code == product_code }
  end
end
