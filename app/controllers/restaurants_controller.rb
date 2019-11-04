class RestaurantsController < ApplicationController
   # before_action :authenticate_user!
  def show
    @restaurant = Restaurant.find(params[:id])
    @dishes =  @restaurant.dishes
    @restaurant_avg = @dishes

         
      @dish_avg = []
        @dishes.each do |d|
             @dish_avg.push(d.ratings.average(:rating))
        end
        @dish_count = @dish_avg.count
        @dish_sum = @dish_avg.sum
        @dish_rating = @dish_sum/@dish_count

        
        
    if params[:price]
      @dishes =  @restaurant.dishes.by_price(params[:price])
    end

    if params[:ratings]
      @dishes =  @restaurant.dishes.by_rating

      @dish_avg = @restaurant.dishes.joins(:ratings).group('dishes.id')
      
    end

    if params[:ratings_filter]
      @dishes =  @restaurant.dishes.sort_ratings(params[:ratings_filter])
    end

    if params[:all]
      @dishes =  @restaurant.dishes
    end

    if params[:veg]
      @dishes =  @restaurant.dishes.where("category_id":1)
    end

    if params[:nonveg]
      @dishes =  @restaurant.dishes.where("category_id":2)
    end

    if params[:drinks]
      @dishes =  @restaurant.dishes.where("category_id":3)
    end

    if params[:desserts]
      @dishes =  @restaurant.dishes.where("category_id":4)
    end
   
  end   
end
