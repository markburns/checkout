module Noths
  class Basket
    def items
      @items ||= []
    end

    def add_items(items)
      items.each{|i| add_item(i) }
    end

    def add_item(item)
      items.push(item)
    end

    def sub_total
      items.map(&:price).inject(&:+) || 0
    end
  end
end


