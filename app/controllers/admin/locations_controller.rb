class Admin::LocationsController < ApplicationController
	def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  def new 
    @location = Location.new
  end   
   
  def create 
     @location = Location.create(location_params)   
    if @location.save   
      respond_to do |format|
        format.html { redirect_to admin_locations_path, notice: 'Location succesfully created' }
      end  
    else   
      render :new   
    end   
  end  


  def edit 
    @location = Location.find(params[:id])   
  
  end 
   
  def update 
   @location = Location.find(params[:id])   
    if @location.update_attributes(location_params)   
      redirect_to admin_locations_path
    else     
      render :edit   
    end     
  end   

  def destroy
    @location = Location.find(params[:id])   
    @location.destroy
    respond_to do |format|
      format.html { redirect_to admin_locations_path, notice: 'location succesfully deleted' }
    end    
  end   

  private
  def location_params   
    params.require(:location).permit(:street, :city, :state, :pincode, :country, :latitude, :longitude)
  end   

end