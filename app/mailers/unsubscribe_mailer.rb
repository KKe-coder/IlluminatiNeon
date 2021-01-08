class UnsubscribeMailer < ApplicationMailer
  def unsubscribe_mail(user)
    @user = user
    mail(
      to:  ENV['GMAIL_ID'],
      subject: '退会通知'
    )
  end
end
