describe Item do
  let(:item) { Item.new product_code: product_code, name: product_name, price: price }

  let(:price) { 1234 }
  let(:product_name) { "Some item"  }
  let(:product_code) { "001" }


  context "with valid values" do
    it "allows access to the values" do
      expect(item.price).to eq 1234
      expect(item.name).to eq "Some item"
      expect(item.product_code).to eq "001"
    end

    it "is an immutable value object" do
      expect(item.respond_to?(:product_code=)).to eq false
      expect(item.respond_to?(:name=)).to eq false
      expect(item.respond_to?(:price=)).to eq false
    end
  end
end
