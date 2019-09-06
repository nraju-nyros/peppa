require "rails_helper"

RSpec.describe Admin::DishesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin/restaurants/48/dishes").to route_to("admin/dishes#index", :restaurant_id => "48")
    end

    it "routes to #new" do
      expect(:get => "/admin/restaurants/48/dishes/new").to route_to("admin/dishes#new",  :restaurant_id => "48")
    end

    it "routes to #show" do
      expect(:get => "admin/restaurants/48/dishes/1").to route_to("admin/dishes#show", :restaurant_id => "48", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/restaurants/48/dishes/1/edit").to route_to("admin/dishes#edit", :restaurant_id => "48", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "admin/restaurants/48/dishes").to route_to("admin/dishes#create", :restaurant_id => "48")
    end

    it "routes to #update via PUT" do
      expect(:put => "admin/restaurants/48/dishes/1").to route_to("admin/dishes#update", :restaurant_id => "48", :id => "1")
    end


    it "routes to #destroy" do
      expect(:delete => "admin/restaurants/48/dishes/1").to route_to("admin/dishes#destroy", :restaurant_id => '48', :id => "1")
    end
  end
end
