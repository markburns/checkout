require "spec_helper"

describe Noths::Checkout do
  let(:item_1) { double "item_1", product_code: "001", name: "Travel Card Holder",     price: 925 }
  let(:item_2) { double "item_2", product_code: "002", name: "Personalised cufflinks", price: 4500 }
  let(:item_3) { double "item_3", product_code: "003", name: "Kids T-shirt",           price: 1995 }
  let(:items) { [item_1, item_2, item_3] }

  let(:promotional_rules) { [] }
  let(:checkout) { Noths::Checkout.new(promotional_rules) }

  def scan_items!
    items.each do |i|
      checkout.scan(i)
    end
  end

  describe "#scan" do
    before do
      scan_items!
    end

    context "each item unique" do
      let(:items) { [item_1, item_2, item_3] }

      it "saves the items" do
        expect(checkout.items).to match_array items
      end
    end

    context "multiple same items" do
      let(:items) { [item_1, item_1, item_1] }

      it "saves the items" do
        expect(checkout.items).to match_array items
      end
    end
  end

  describe "#total" do
    before do
      scan_items!
    end

    context "with decimal total" do
      before do
        expect(checkout).to receive(:sub_total).and_return 10.0
        expect(checkout).to receive(:basket_discounts).and_return 0.4
      end

      it "rounds up" do
        expect(checkout.total).to eq 10
      end
    end

    context "with no promotions" do
      let(:promotional_rules) { [] }

      let(:items) { [item_1, item_2, item_3] }
      it do
        expect(checkout.total).to eq item_1.price + item_2.price + item_3.price
      end
    end

    context "functional spec collaborating with discounts" do
      let(:basket_discount) { Noths::BasketDiscount.new(6000, 10) }
      let(:item_discount) {   Noths::ItemDiscount.new(2, 850, "001")}


      context "with a single promotion" do
        let(:promotional_rules) { [basket_discount] }

        let(:items) { [item_1, item_3, item_1, item_2] }

        it do
          expect(checkout.basket_discounts).to eq 834.5
        end

        it do
          sub_total = items.map(&:price).inject(&:+)
          discount = sub_total * 0.1
          expect(checkout.total).to eq  (sub_total - discount).ceil
        end
      end

      context "with multiple promotions but only one applying" do
        let(:promotional_rules) { [basket_discount, item_discount] }

        context do
          let(:discounted_value) { 850 }
          let(:items) { [item_1, item_3, item_1] }

          it do
            sub_total = items.map(&:price).inject(&:+)
            item_discount_value = (item_1.price * 2) - (discounted_value * 2)
            #only the item discount applies

            expect(checkout.total).to eq (sub_total - item_discount_value).floor
          end
        end

        context "it applies basket discounts after item discounts" do
          let(:items) { [item_1, item_2, item_1, item_3] }

          it do
            sub_total = item_1.price * 2 + item_2.price + item_3.price
            item_discount_value = (925*2)-(850*2)
            basket_discount_value = sub_total * 0.1
            expect(checkout.item_discounts).to eq item_discount_value
            expect(checkout.basket_discounts).to eq (sub_total - item_discount_value) * 0.1
            expect(checkout.total).to eq 7376
          end
        end
      end
    end
  end
end
