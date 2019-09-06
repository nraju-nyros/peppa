class ContactsMailer < ApplicationMailer
	def send_email(contact)
	  	@contact  = contact
	    mail(from: 'nraju.nyros@gmail.com', to: 'nraju.nyros@gmail.com', subject: 'You have message')
    end

  # def confirm_email(gmail)
  # 	@body = "mail merge is started"
  #   mail(from: 'nraju.nyros@gmail.com',to: 'nraju.nyros@gmail.com', subject: 'confirmation message')
  # end
end
