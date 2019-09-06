class UsersController < ApplicationController

  def index
    @users = User.all  
  end  

  
 
  def show
    @user = User.find(params[:id])
  end

   
  def create   
    @user = User.new(user_params)   
    if @user.save   
      redirect_to users_path   
    else   
      render :new   
    end   
  end  


  def edit 
    @user = User.find(params[:id]) 
  end 
   
  def update   
    @user = User.find(params[:id])   
    if @user.update_attributes(user_params)   
      redirect_to '/users'   
    else     
      render :edit   
    end   
  end   

  def destroy   
   @user = User.find(params[:id])   
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'user succesfully deleted' }
      format.json { head :no_content}
      format.js  { render :layout => false }
    end    
  end   
   
  private
  def user_params   
    params.require(:user).permit(:name)   
  end   
  
 

end  
