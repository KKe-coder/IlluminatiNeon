class ContactsController < ApplicationController

  def new
    @contact = Contact.new
    if user_signed_in?
      @contact.name = current_user.name
      @contact.email = current_user.email
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save
    ContactMailer.send_mail(@contact).deliver_now
    redirect_to new_contacts_path, notice: '管理者にメールが送信されました。'
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :message, :email)
  end

end
