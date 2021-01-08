class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save
    ContactMailer.send_mail(@contact).deliver_now
    redirect_to new_contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :message)
  end

end
