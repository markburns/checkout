describe Noths::Basket do
  let(:item_1) { double "item_1", product_code: "001", name: "Travel Card Holder",     price: 925 }
  let(:item_2) { double "item_2", product_code: "002", name: "Personalised cufflinks", price: 4500 }
  let(:item_3) { double "item_3", product_code: "003", name: "Kids T-shirt",           price: 1995 }
  let(:items)  { [item_1, item_2, item_3] }

  let(:basket) { Noths::Basket.new.tap{|b| b.add_items(items)} }

  describe "#sub_total" do
    it "calculates the sub total" do
      expect(basket.sub_total).to eq 7420
    end
  end
end

