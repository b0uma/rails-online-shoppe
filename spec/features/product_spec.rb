require 'rails_helper'

describe "Product", js: true do
  let(:product) { Product.create({name: 'iPhone 3G', price: 399, description: 'Sturdy', image_url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/IPhone_3G_rear.jpg'}) }
  let (:administrator) { User.create(name: 'master', email: 'aaa', password: '123', admin: true) }

  context 'a user' do
    it 'can see the page title' do
      visit root_path
      expect(page).to have_content("Items for sale!")
    end

    describe "product creation" do
      let(:name) { "Nexus 5" }
      let(:description) { "Just OK"}
      let(:price) { 349.99 }
      let(:image_url) { 'sample' }
      let(:quantity) { 2 }

      it 'can create a new product when authorized' do
        page.set_rack_session(user_id: administrator.id)
        visit admin_path
        click_link 'New Product'
        fill_in 'Name', with: name
        fill_in 'Description', with: description
        fill_in 'Price', with: price
        fill_in 'Image url', with: image_url
        fill_in 'Quantity', with: quantity
        click_button 'Save'
        expect(page).to have_content description
      end
    end
  end
end
