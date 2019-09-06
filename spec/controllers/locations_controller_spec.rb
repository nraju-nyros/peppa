require 'rails_helper'

RSpec.describe Admin::LocationsController, type: :controller do

  let(:valid_session) { {} }

  let(:attr) do 
      { :street => 'main road', :city => 'Yanam', :state => 'Ap', :pincode => 533001, :country => 'India' }
  end

	context 'GET #index' do
    it 'returns a success response' do
      get :index
       expect(response).to be_successful
    end
  end

  context 'GET #show' do
    it 'returns a success response' do
      location = Location.create!(:street => 'main road', :city => 'Kakinda', :state => 'Ap', :pincode => 533001, :country => 'India' )
      get :show, params: { id:location.to_param }
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
      it "creates a new Location" do
        expect {
          post :create, params: {location: attr}, session: valid_session
        }.to change(Location, :count).by(1)
      end
    end
  end

  describe "PUT update/:id" do
    before(:each) do
        location = Location.create!(:street => 'main road', :city => 'Kakinda', :state => 'Ap', :pincode => 533001, :country => 'India' )
        put :update, params: {id: location.to_param, location: attr}
      location.reload
    end
  end


  describe "DELETE destroy" do
    it "destroys the requested locations" do
      location = Location.create!(:street => 'main road', :city => 'Kakinda', :state => 'Ap', :pincode => 533001, :country => 'India' )
      expect {
        delete :destroy, params: { id:location.to_param }
      }.to change(Location, :count).by(-1)
    end
  end
  
end
	