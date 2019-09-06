class LikesController < ApplicationController
   before_action :find_dish
   before_action :find_like, only: [:destroy]
   before_action :authenticate_user!, :except => [:index]


  def create
	  if already_liked?
	    flash[:notice] = "You can't like more than once"
	  else
	    @dish.likes.create(user_id: current_user.id)
	  end
	  redirect_to dish_path(@dish)
  end

  def already_liked?

		Like.where(user_id: current_user.id, dish_id:
		params[:dish_id]).exists?
  end

  def destroy
	  if !(already_liked?)
	    flash[:notice] = "Cannot unlike"
	  else
	    @like.destroy
	  end
	  redirect_to dish_path(@dish)
  end

  def find_like
    @like = @dish.likes.find(params[:id])
  end

  private
  def find_dish
    @dish = Dish.find(params[:dish_id])
  end
end
