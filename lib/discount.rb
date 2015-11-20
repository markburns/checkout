class Discount
  include Virtus.model

  def apply(items: , running_sub_total: )
    discount = discount(items: items, running_sub_total: running_sub_total)

    running_sub_total - discount
  end
end



