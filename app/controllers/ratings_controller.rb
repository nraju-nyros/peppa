class RatingsController < ApplicationController
 before_action :authenticate_user!, only: [:create]
	def index
    @rating = Rating.all
    
  end
  
  def show
    @rating = rating.find(params[:id])
  end

  def new   
     @rating = Rating.new
  end   
   

  def create 

    @dish = Dish.find(rating_params[:dish_id])
    @rating = Rating.create(rating_params) 

    if @rating.save 
      redirect_to dish_path(@dish) 
    else   
      redirect_to dish_path(@dish) 
    end   
  end  

  def edit 
    @rating = rating.find(params[:id]) 
  end 
   
  def update   
    @rating = rating.find(params[:id])   
    if @rating.update_attributes(rating_params)   
      redirect_to admin_restaurant_dishes_path
    else     
      render :edit   
    end   
  end   

  def destroy   
    @rating = rating.find(params[:id])   
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to admin_restaurant_dishes_path, notice: 'rating succesfully deleted' }
    end    
  end   
   
  private

  def rating_params   
    params.require(:rating).permit(:rating, :user_id, :dish_id, :comments, :user_name) 
  end   

end
