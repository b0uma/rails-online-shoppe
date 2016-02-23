require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:valid) do
    Category.new(name: 'Jewelry')
  end

  let(:invalid) do
    Category.new
  end

  describe "category validations" do
    context "will create an error" do
      it "when fields are empty" do
        invalid.save
        expect(invalid.errors[:name]).to include("can't be blank")
      end
    end
    it 'saves with valid data' do
      expect{valid.save}.to change{Category.count}.by(1)
    end
    it 'can access associated products' do
      expect(valid).to respond_to(:products)
    end
  end
end
