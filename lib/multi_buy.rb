class MultiBuy
  include Virtus.model
  attribute :discount_value,   Integer
  attribute :discount_trigger, Integer
  attribute :product_code,     String

  def discount(items: , running_sub_total: nil)
    items = relevant_items(items)

    items.count / discount_trigger * discount_value
  end

  private

  def relevant_items(items)
    items.select{|i| i.product_code == product_code}
  end


end
