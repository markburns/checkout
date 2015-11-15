require "spec_helper"

describe BasketDiscount do
  let(:sub_total) { 7420 }
  let(:basket) { double("basket", sub_total: sub_total)  }

  let(:promotional_rule) { BasketDiscount.new(discount_trigger, discount_rate) }
  let(:discount) { promotional_rule.discount(basket, sub_total) }

  describe "#discount" do
    context "over £60 is a 10% discount" do
      let(:discount_trigger) { 6000 }
      let(:discount_rate) { 10.0 }

      it "when spending over £60 you get 10% off" do
        expect(discount).to eq 7420 * 0.1
      end
    end

    context "over £0 is a 50% discount" do
      let(:discount_trigger) { 0 }
      let(:discount_rate) { 50 } 

      context "with £500 basket" do
        let(:sub_total) { 500 }

        it do
          expect(discount).to eq 250
        end
      end

      context "with £0 basket" do
        let(:sub_total) { 0 }

        it do
          expect(discount).to eq 0
        end
      end
    end
  end
end
