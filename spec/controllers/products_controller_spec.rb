require 'rails_helper'
require 'auth_helper'

RSpec.describe ProductsController, type: :controller do
  let(:valid_attributes) do
    {name: 'Goulash', price: 4.50, description: 'Tasty', image_url: 'https://upload.wikimedia.org/wikipedia/commons/7/79/Goulash_from_usa.jpg', quantity: 2}
  end

  let(:invalid_attributes) do
    {name: '', price: -10, description: '', quantity: nil}
  end

  include AuthHelper


  describe "GET #index" do
    it "assigns all products as @products" do
      product = Product.create!(valid_attributes)
      get :index, {}
      expect(assigns(:products)).to eq([product])
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      product = Product.create!(valid_attributes)
      get :show, {:id => product.to_param}
      expect(assigns(:product)).to eq(product)
    end
  end

  context "for an admin user" do

    let (:administrator) { User.create(name: 'master', email: 'juicy', password: '123', admin: true) }

    before(:each) { session[:user_id] = administrator.id }

    describe "GET #new" do
      it "assigns a new product as @product" do
        get :new, {}
        expect(assigns(:product)).to be_a_new(Product)
      end
    end

    describe "GET #edit" do
      it "assigns the requested product as @product" do
        product = Product.create!(valid_attributes)
        get :edit, {:id => product.to_param}
        expect(assigns(:product)).to eq(product)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Product" do
          expect {
            post :create, {:product => valid_attributes}
          }.to change(Product, :count).by(1)
        end

        it "assigns a newly created product as @product" do
          post :create, {:product => valid_attributes}
          expect(assigns(:product)).to be_a(Product)
          expect(assigns(:product)).to be_persisted
        end

        it "redirects to the created product" do
          post :create, {:product => valid_attributes}
          expect(response).to redirect_to(Product.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved product as @product" do
          post :create, {:product => invalid_attributes}
          expect(assigns(:product)).to be_a_new(Product)
        end

        it "re-renders the 'new' template" do
          post :create, {:product => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {name: 'iPhone 4S', price: 499.0, description: 'New and improved', image_url: 'https://upload.wikimedia.org/wikipedia/commons/2/20/WatchOS_2_Logo.png', quantity: 1}
        }

        it "updates the requested product" do
          product = Product.create!(valid_attributes)
          put :update, {:id => product.to_param, :product => new_attributes}
          product.reload
          expect({name: product.name, price: product.price, description: product.description, image_url: product.image_url, quantity: product.quantity}).to eq(new_attributes)
        end

        it "assigns the requested product as @product" do
          product = Product.create!(valid_attributes)
          put :update, {:id => product.to_param, :product => valid_attributes}
          expect(assigns(:product)).to eq(product)
        end

        it "redirects to the product" do
          product = Product.create!(valid_attributes)
          put :update, {:id => product.to_param, :product => valid_attributes}
          expect(response).to redirect_to(product)
        end
      end

      context "with invalid params" do
        it "assigns the product as @product" do
          product = Product.create!(valid_attributes)
          put :update, {:id => product.to_param, :product => invalid_attributes}
          expect(assigns(:product)).to eq(product)
        end

        it "re-renders the 'edit' template" do
          product = Product.create!(valid_attributes)
          put :update, {:id => product.to_param, :product => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested product" do
        product = Product.create!(valid_attributes)
        expect {
          delete :destroy, {:id => product.to_param}
        }.to change(Product, :count).by(-1)
      end

      it "redirects to the products list" do
        product = Product.create!(valid_attributes)
        delete :destroy, {:id => product.to_param}
        expect(response).to redirect_to(products_url)
      end
    end
  end

  context "for a normal user" do
    describe "DELETE #destroy" do
      it "does not destroy the requested product" do
        product = Product.create!(valid_attributes)
        expect {
          delete :destroy, {:id => product.to_param}
        }.to change(Product, :count).by(0)
      end

      it "returns a 401 status" do
        product = Product.create!(valid_attributes)
        delete :destroy, {:id => product.to_param}
        expect(response.status).to be(401)
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) do
          {name: 'iPhone 4S', price: 499.0, description: 'New and improved', image_url: 'https://upload.wikimedia.org/wikipedia/commons/2/20/WatchOS_2_Logo.png', quantity: 1}
        end

        it "does not update the requested product" do
          product = Product.create!(valid_attributes)
          put :update, {:id => product.to_param, :product => new_attributes}
          product.reload
          expect({name: product.name, price: product.price, description: product.description, image_url: product.image_url, quantity: product.quantity}).to eq(valid_attributes)
        end

        it "returns a 401 status" do
          product = Product.create!(valid_attributes)
          put :update, {:id => product.to_param, :product => valid_attributes}
          expect(response.status).to eq(401)
        end
      end
    end
    describe "POST #create" do
      context "with valid params" do
        it "does not create a new Product" do
          expect {
            post :create, {:product => valid_attributes}
          }.to change(Product, :count).by(0)
        end

        it "returns a 401 status" do
          post :create, {:product => valid_attributes}
          expect(response.status).to eq(401)
        end
      end

    end
  end

  describe "Routing" do
    it "/ routes to products#index" do
      expect(:get => "/").to route_to("products#index")
    end
  end
end
