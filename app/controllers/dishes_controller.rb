class DishesController < ApplicationController
  # before_action :authenticate_user!
	def index
    @dishes = Dish.all
  end

  def show
    @rating = Rating.new
    @dish = Dish.find(params[:id])
  end

  def new 
    @dish = Dish.new
  end   
   
  def create 
     @dish = Dish.create(dish_params)   
    if @dish.save   
      respond_to do |format|
        format.html { redirect_to dishes_path, notice: 'Dish succesfully created' }
      end  
    else   
      render :new   
    end   
  end  


  def edit 
  
  end 
   
  def update 
   @dish = Dish.find(params[:id])   
    if @dish.update_attributes(dish_params)   
      redirect_to dishes_path
    else     
      render :edit   
    end     
  end   

  def destroy
    @dish = Dish.find(params[:id])   
    @dish.destroy
    respond_to do |format|
      format.html { redirect_to dishes_path, notice: 'dish succesfully deleted' }
    end    
  end   

  private
  def dish_params   
    params.require(:dish).permit(:name, :price, :category_id)
  end   
end
