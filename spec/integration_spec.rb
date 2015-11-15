describe Checkout do
  let(:item_1) { Item.new price: 925,  product_code: "001", name: "Travel Card Holder"     }
  let(:item_2) { Item.new price: 4500, product_code: "002", name: "Personalised cufflinks" }
  let(:item_3) { Item.new price: 1995, product_code: "003", name: "Kids T-shirt"           }

  let(:items) { [item_1, item_2, item_3] }

  let(:promotional_rules) { [] }
  let(:checkout) { Checkout.new(promotional_rules) }

  def scan_items!
    items.each do |i|
      checkout.scan(i)
    end
  end

  before do
    scan_items!
  end

  context "with promotions" do
    let(:promotional_rules) { [basket_discount, item_discount] }
    let(:basket_discount) { BasketDiscount.new(6000, 10) }
    let(:item_discount) {   ItemDiscount.new(2, 850, "001")}

    context "items 1,2,3" do
      let(:items) { [item_1, item_2, item_3] }
      #Basket: 001,002,003
      #Total price expected: £66.78



      it do
        expect(checkout.total).to eq 6678
      end
    end

    context "items 1,3,1" do
      let(:items) { [item_1, item_3, item_1] }

      #Basket: 001,003,001
      #Total price expected: £36.95
      it do
        checkout
        sub_total = 925 + 1995 + 925
        sub_total = 3845
        expect(checkout.sub_total).to eq 3845
        expect(checkout.total).to eq 3695
      end
    end

    context "items 1,2,1,3" do
      #Basket: 001,002,001,003
      #Total price expected: £73.76

      let(:items) { [item_1, item_2, item_1, item_3] }

      it do
        expect(checkout.total).to eq 7376
      end
    end
  end
end


