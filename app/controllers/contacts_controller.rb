class ContactsController < ApplicationController
	def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create(contact_params)
    if @contact.save
     DelayGmailJob.set(wait: 4.seconds).perform_later @contact   
    	respond_to do |format|
        format.html { redirect_to root_path, notice: 'Email sent succesfully' }
      end  

    else
      redirect_to home_index_path
    end
  end
  
  def thanks
  end

  private
  def contact_params   
    params.require(:contact).permit(:name, :email, :message)
  end 
    
end
