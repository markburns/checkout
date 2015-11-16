require "spec_helper"

describe ItemDiscount do
  let(:item_1) do
    double "item_1", product_code: "001",
                     name: "Travel Card Holder",
                     price: 925
  end

  let(:item_2) do
    double "item_2", product_code: "002",
                     name: "Personalised cufflinks",
                     price: 4500
  end

  let(:promotional_rule) { ItemDiscount.new(items) }

  describe "#discount" do
    let(:discount_trigger) { 2 }
    let(:discounted_value) { 850 }
    let(:product_code) { "001" }
    let(:promotional_rule) do
      ItemDiscount.new(discount_trigger: discount_trigger,
                       discounted_value: discounted_value,
                       product_code: product_code)
    end
    let(:basket) { double "basket", items: items }

    subject(:discount) { promotional_rule.discount(basket) }

    context "when buying 2 or more items the price drops to £8.50" do
      context "with 2 items" do
        let(:items) { [item_1, item_1] }

        it do
          expected_discount = (item_1.price * 2) - (discounted_value * 2)
          expect(discount).to eq expected_discount
        end
      end

      context "with 3 items" do
        let(:items) { [item_1, item_1, item_1] }

        it do
          expected_discount = (item_1.price * 3) - (discounted_value * 3)

          expect(discount).to eq expected_discount
        end
      end
    end

    context "with irrelevant items in the basket " do
      let(:items) { [item_1, item_1, item_2] }

      it do
        expected_discount = (item_1.price * 2) - (discounted_value * 2)
        expect(discount).to eq expected_discount
      end
    end

    context "with no relevant_items" do
      let(:items) { [item_2, item_2] }

      it do
        expect(discount).to eq 0
      end
    end
  end
end
