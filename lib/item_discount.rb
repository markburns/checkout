class ItemDiscount < Discount
  attribute :discount_trigger, Integer
  attribute :discounted_value, Integer
  attribute :product_code,     String

  def discount(items:, running_sub_total: nil)
    discountable = relevant_items(items)

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
