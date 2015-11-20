[![Code Climate](https://codeclimate.com/github/markburns/checkout/badges/gpa.svg)](https://codeclimate.com/github/markburns/checkout)

Usage
-----

```
git clone https://github.com/markburns/checkout.git
cd checkout
```

```ruby
require "./lib/checkout"

#10% off £60
basket_discount = BasketDiscount.new(discount_trigger: 6000, discount_rate: 10)

item_1 = Item.new price: 925,  product_code: "001", name: "Travel Card Holder"
item_2 = Item.new price: 4500, product_code: "002", name: "Personalised cufflinks"
item_3 = Item.new price: 1995, product_code: "003", name: "Kids T-shirt"


#reduce price of more than 2 travel card holders to £8.50
item_discount   = ItemDiscount.new(discount_trigger: 2, discounted_value: 850, product_code: "001")
checkout = Checkout.new([basket_discount, item_discount])

checkout.scan item_1
checkout.scan item_2
checkout.scan item_3


checkout.total
#=> 6678
