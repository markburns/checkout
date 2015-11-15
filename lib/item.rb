class Item
  include Virtus.value_object

  values do
    attribute :product_code,  String
    attribute :name,  String
    attribute :price, Integer
  end
end
