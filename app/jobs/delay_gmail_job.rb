class DelayGmailJob < ApplicationJob
  queue_as :default

  def perform(contact)
  	ContactsMailer.send_email(contact).deliver_now
  end

end
