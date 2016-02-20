require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {name: 'Big J', email: 'biggie@devbootcamp.com', password: 'open sesame'}
  end

  let(:invalid_attributes) do
    {name: '', email: '', password: ''}
  end

  let(:hacking_attempt) do
    {name: '1337', email: 'h4cker@devbootcamp.com', password: 'lol', admin: true}
  end

  describe "GET signup" do
    it "assigns a new product as @product" do
      get :new, {}
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}
          }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the products page after signup" do
        post :create, {:user => valid_attributes}
        expect(response).to redirect_to "/products"
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_attributes}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {:user => invalid_attributes}
        expect(response).to render_template("new")
      end

      it "does not let users set the admin field from the app" do
        post :create, {:user => hacking_attempt}
        expect(User.last.admin).to be(nil)
      end
    end
  end

   describe "Routing" do
    it "/signup routes to users#new" do
      expect(:get => "/signup").to route_to("users#new")
    end
  end

end
