require 'rails_helper'

RSpec.describe Admin::RestaurantsController, type: :controller do

  let(:valid_session) { {} }
  let(:attr) do 
      { :name => 'new title', :email => 'new@gmail.com', :phone => 9878787878 }
  end

	context 'GET #index' do
    it 'returns a success response' do
      get :index
       expect(response).to be_successful
    end
  end

  context 'GET #show' do
    it 'returns a success response' do
      restaurant = Restaurant.create!(name: 'SB RESIDENCY', phone: 8787878787, email: 'sb@example.com')
      get :show, params: { id:restaurant.to_param }
     expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Restaurant" do
        expect {
          post :create, params: {restaurant: attr}, session: valid_session
        }.to change(Restaurant, :count).by(1)
      end
    end
  end

  describe "PUT update/:id" do
    before(:each) do
        restaurant = Restaurant.create!(name: 'SB RESIDENCY', phone: 8787878787, email: 'sb@example.com')
        put :update, params: {id: restaurant.to_param, restaurant: attr}
      restaurant.reload
    end
    it { expect(response).to redirect_to(admin_restaurants_path) }
  end


  describe "DELETE destroy" do
    it "destroys the requested restaurants" do
      restaurant = Restaurant.create!(name: 'SB RESIDENCY', phone: 8787878787, email: 'sb@example.com')
      expect {
        delete :destroy, params: { id:restaurant.to_param }
      }.to change(Restaurant, :count).by(-1)
    end

    it "redirects to the dishes list" do
      restaurant = Restaurant.create!(name: 'SB RESIDENCY', phone: 8787878787, email: 'sb@example.com')
        delete :destroy,  params: { id:restaurant.to_param }
      expect(response).to redirect_to(admin_restaurants_path)
    end
  end

end
	