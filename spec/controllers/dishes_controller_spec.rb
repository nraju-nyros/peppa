require 'rails_helper'
RSpec.describe Admin::DishesController, type: :controller do

	let(:valid_session) { {} }
  let(:attr) do
    {:name => 'Biryani', :price => 45, :category_id => 1} 
  end

	context 'GET#index' do
		it 'returns a success response' do
      @restaurant = Restaurant.find(48)
			get :index ,params: { restaurant_id:@restaurant.to_param }
		  expect(response).to be_successful
		end
	end

	context 'GET #show' do
    it 'returns a success response' do
      @restaurant = FactoryBot.create :restaurant
      dish =FactoryBot.create :dish 
      get :show, params: {restaurant_id:@restaurant.to_param, id:dish.to_param }
       expect(response).to be_successful
    end
  end

  describe "GET/new" do
    it "new dish " do
      @restaurant = Restaurant.find(48)
      post :new, params: {restaurant_id:@restaurant.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Dish" do
        @restaurant = Restaurant.find(48)
        expect {
          post :create, params: {restaurant_id:@restaurant.to_param, dish: attr}, session: valid_session
        }.to change(Dish, :count).by(1)
      end
    end
  end

  describe "PUT update/:id" do
    it 'redirects to the root page' do
      @restaurant = Restaurant.find(48)
    	dish = Dish.create!(name: 'Biryani', price: 100, category_id: 2)
      put :update, params: {restaurant_id:@restaurant.to_param, id: dish.to_param, dish: attr}, session: valid_session
      expect(response).to redirect_to admin_restaurant_dishes_path
    end
  end


  describe "DELETE destroy" do
    it "destroys the requested dishs" do
      @restaurant = Restaurant.find(48)
      dish = Dish.create!(name: 'Biryani', price: 50, category_id: 1)
      expect {
        delete :destroy, params: {restaurant_id:@restaurant, id:dish.to_param }
      }.to change(Dish, :count).by(-1)
    end

    it "redirects to the dishes list" do
      dish = Dish.create!(name: 'Biryani', price: 50, category_id: 1)
       @restaurant = Restaurant.find(48)
        delete :destroy,  params: {restaurant_id:@restaurant,id:dish.to_param }
      expect(response).to redirect_to(admin_restaurant_dishes_path)
    end
  end

end
