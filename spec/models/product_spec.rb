require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:valid) do
    Product.new({name: 'iPhone 3G', price: 399, description: 'Sturdy', image_url: Faker::Avatar.image, quantity: 1})
  end

  let(:blank) do
    Product.new({name: '', price: nil, description: '', image_url: '', quantity: nil})
  end

  let(:negative_price) do
    Product.new({name: 'iPhone 3G', price: -100, description: 'Sturdy', image_url: Faker::Avatar.image, quantity: 1})
  end

  let(:negative_quantity) do
    Product.new({name: 'iPhone 3G', price: -100, description: 'Sturdy', image_url: Faker::Avatar.image, quantity: -1})
  end

  describe "product validations" do
    context "will create an error" do
      it "when fields are empty" do
        blank.save
        expect(blank.errors[:name]).to include("can't be blank")
        expect(blank.errors[:description]).to include("can't be blank")
        expect(blank.errors[:price]).to include("can't be blank")
        expect(blank.errors[:image_url]).to include("can't be blank")
      end
      it "the price is negative" do
        negative_price.save
        expect(negative_price.errors[:price]).to include("must be greater than -1")
      end
      it "the quantity is negative" do
        negative_quantity.save
        expect(negative_quantity.errors[:quantity]).to include("must be greater than 0")
      end
    end
    it 'saves with valid data' do
      expect{valid.save}.to change{Product.count}.by(1)
    end
    it 'can access associated categories' do
      expect(valid).to respond_to(:categories)
    end
  end
end
