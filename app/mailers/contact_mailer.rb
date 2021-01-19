class ContactMailer < ApplicationMailer
  def send_mail(contact)
    @contact = contact
    mail(
      to:  ENV['GMAIL_ID'],
      subject: "【IlluminatioNeon】問い合わせ通知"
    )
  end
end
