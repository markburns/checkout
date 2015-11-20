describe MultiBuyDiscount do
  describe "#discount" do
    let(:item_1) do
      Item.new price: discounted_value,
        product_code: "003",
        name: "Kids T-shirt"
    end

    let(:item_2) do
      Item.new price: 2017,
        product_code: "001",
        name: "Something else"
    end

    let(:discounted_value) { 1995 }

    let(:items) { [item_1, item_1, item_1, item_1,
                   item_2, item_2,
                   ] 
    }

    let(:multi_buy) { MultiBuyDiscount.new(discounted_value: discounted_value, discount_trigger: discount_trigger, product_code: "003") }

    context "not triggering a discount" do
      let(:discount_trigger) { 5 }

      it "returns no discount" do
        expect(multi_buy.discount(items: items)).to eq 0
      end
    end

    context "triggering a discount exactly" do
      let(:discount_trigger) { 4 }

      it "buy 4 get 1 free" do
        expect(multi_buy.discount(items: items)).to eq discounted_value
      end
    end


    context "triggering a discount once" do
      let(:discount_trigger) { 3 }

      it "just overtriggers a discount" do
        expect(multi_buy.discount(items: items)).to eq discounted_value
      end
    end

    context "triggering a discount twice" do
      let(:discount_trigger) { 2 }

      it "buy 4 get 2 free" do
        expect(multi_buy.discount(items: items)).to eq discounted_value * 2
      end
    end

    context "with no matching items" do
      let(:items) { [ item_2, item_2] }
      let(:discount_trigger) { 1 }

      it "returns no discount" do
        expect(multi_buy.discount(items: items)).to eq 0
      end
    end

  end
end
