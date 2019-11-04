class HomeController < ApplicationController
    

  def index
    if  params[:location]
      @locations = Location.where("city LIKE ?", "%#{params[:location]}%")
      restaurants = []
      location_dishes = []
        @locations.each do |l|
          l.restaurants.each do |r|
            restaurants.push(r)
              r.dishes.each do |d|
                location_dishes.push(d)
              end
          end
        end
      @dishes = location_dishes.paginate(:page => params[:page], :city => params[:location], :per_page => 50)

    else
     
      @dishes = Dish.paginate(:page => params[:page], :per_page => 6)
          respond_to do |format|
            format.html
            format.js
          end
    end
  end

  def show
     @dish = Dish.find(params[:id])
  end

  def search 

    map_location
    if  params[:search]
    @dishes = Dish.paginate(page: params[:page],:per_page => 6).where("name LIKE ?", "%#{params[:search]}%")
    end 

    if params[:price]
      @dishes = Dish.paginate(page: params[:page],:per_page => 50).by_price(params[:price]).where("name LIKE ?", "%#{params[:search]}%")
    end

    if params[:ratings]
      @dishes = Dish.paginate(page: params[:page],:per_page => 50).by_rating.where("name LIKE ?", "%#{params[:search]}%")
    end

    if params[:ratings_filter]
     @dishes = Dish.paginate(page: params[:page],:per_page => 50).sort_ratings(params[:ratings_filter]).where("name LIKE ?", "%#{params[:search]}%")
    end

    if params[:category]
      @dishes = Dish.paginate(page: params[:page],:per_page => 50).by_category(params[:category]).where("name LIKE ?", "%#{params[:search]}%")
    end

    if params[:restaurant_id]
      @restaurant = Restaurant.find(params[:restaurant_id])
      @dish1 = @restaurant.dishes.where("name LIKE ?", "%#{params[:search]}%")
      @dish2 = @restaurant.dishes.all.where("name NOT LIKE ?", "%#{params[:search]}%")
      @dishes = (@dish1  + @dish2).paginate(page: params[:page],:per_page => 50)
    end

  end

  # locations to maps
  private
  def map_location
    @dishes = Dish.all.where("name LIKE ?", "%#{params[:search]}%")
    locations = []
    restaurant = []
    @dishes.each do |d|
      d.restaurants.each do |r|
          restaurant.push(r)
        r.locations.each do |l|   
          locations.push(l)
        end
      end 
    end
      gon.locations = locations 
      gon.restaurant = restaurant
      

      # restaurant dishes count for map
      restaurant_dish = []
      restaurant.each do |k|
        count =  k.dishes.count
        restaurant_dish.push(count)
      end
      gon.restaurant_dish = restaurant_dish


      # restaurant pictures for map
      pictures = []
      restaurant.each do |r|
        r.pictures.each do |p|
          pictures.push(p)
        end
      end
      gon.pictures = pictures
  end
end