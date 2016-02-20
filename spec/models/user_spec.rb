require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid) do
    User.new({name: 'Big J', email: 'biggie@devbootcamp.com', password: 'open sesame'})
  end

  let(:invalid) do
    User.new({name: '', email: '', password: ''})
  end

  describe "user validations" do
    context "will create an error" do
      it "when fields are empty" do
        invalid.save
        expect(invalid.errors[:name]).to include("can't be blank")
        expect(invalid.errors[:email]).to include("can't be blank")
        expect(invalid.errors[:password_digest]).to include("can't be blank")
      end
    end
    it 'saves with valid data' do
      expect{valid.save}.to change{User.count}.by(1)
    end
  end
end
