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
    if already_rated?
      flash[:notice] = "You can't like more than once"
    else
      @rating = Rating.create(rating_params) 
      @rating.save 
      redirect_to dish_path(@dish) 
    end  
  end

  def already_rated?
    Rating.where(user_id: current_user.id, dish_id:
    rating_params[:dish_id]).exists?
  end

  def edit 
    @rating = Rating.find(params[:id]) 
    respond_to do |format|
      format.js
    end
  end 
   
  def update   
    @dish = Dish.find(params[:dish_id])
    @rating = Rating.find(params[:id])

    respond_to do |format|   
      if @rating.update_attributes(rating_params)   
        format.html { redirect_to dish_path(@dish)  }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end 

  def destroy   
    @rating = Rating.find(params[:id])
    @dish = Dish.find(params[:dish_id])
    @rating.destroy

    respond_to do |format|
     format.js
    end 
  end   


  def upvote
    @dish = Dish.find(params[:dish_id])
    @rating = Rating.find(params[:id])
    @rating.upvote_from current_user

      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js {}
      end

  end

   def downvote
      @dish = Dish.find(params[:dish_id])
      @rating =@dish.ratings.find(params[:id])
      @rating.downvote_from current_user
       respond_to do |format|
        format.html { redirect_to request.referrer }
        format.js {}
      end

  end


  private
  def rating_params   
    params.require(:rating).permit(:rating, :user_id, :dish_id, :comments, :user_name) 
  end     

  private
  def find_dish
    @dish = Dish.find(rating_params[:dish_id])
  end  
end
