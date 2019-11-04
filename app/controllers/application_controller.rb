class ApplicationController < ActionController::Base
  respond_to :html, :json
	# def after_sign_out_path_for(resource_or_scope)
 #    new_admin_session_path
 #  end

 #  def after_sign_in_path_for(resource_or_scope)
 #    admin_restaurants_path
 #  end
 # before_action :store_current_location, :unless => :devise_controller?
 #  def store_current_location
 #    store_location_for(:user, request.url)
 #  end


   before_action :store_user_location!, if: :storable_location?
 
  

  private
   
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
 

  def after_sign_out_path_for(resource_or_scope)
  request.referer  || super
  end

   def after_sign_in_path_for(resource_or_scope)

    stored_location_for(resource_or_scope) || super

  end

   def after_sign_up_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end


  protect_from_forgery with: :exception   
     
  helper_method :current_user  
  
 before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

 
end
