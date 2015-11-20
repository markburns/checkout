class MultiBuyDiscount < ItemDiscount
  def discount(items: , running_sub_total: nil)
    items = relevant_items(items)

    items.count / discount_trigger * discounted_value
  end
end
