require 'rails_helper'
RSpec.describe HomeController, type: :controller do

  let(:valid_session) { {} }

	context 'GET #index' do
    it 'returns a success response' do
      get :index
       expect(response).to be_successful
    end

    it 'it responds to a html template' do
      get :index
      expect(response.content_type).to eq "text/html"
    end
  end

  describe "POST search" do
    it "finds the dishes by search name" do
      get :search, params: {name: 'bir'}
      expect(response).to be_successful
    end

    it "sort dishes by price" do
      get :search, { :params => {:price => 'price'}}
      controller.params[:price].should eql 'price'
    end

    it "sort dishes by rating" do
      get :search, { :params => {:ratings => 'ratings'}}
      controller.params[:ratings].should eql 'ratings'
    end
    

    it "sort by ratings_filter" do
      get :search, params: {raings_filter: 4}
      expect(response).to be_successful
    end

    it "sort by category" do
      get :search, params: {category: 1}
      expect(response).to be_successful
    end 

    it "sort by restaurants" do
      @restaurant = FactoryBot.create :restaurant
      get :search, params: {restaurant_id: @restaurant.id}
       controller.params[:restaurant_id].should eql @restaurant.id.to_s
       expect(response).to be_successful
    end
  end 

end
	