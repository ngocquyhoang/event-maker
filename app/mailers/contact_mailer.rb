class ContactMailer < ApplicationMailer
  default from: 'no-reply@zevent.date'

  def reply_contact_email( message, content )
    @mail_content = content
    @message = message
    mail(to: @message.email, subject: '[Reply] Thanks for contacting :: EVENT MAKER')
  end

  def send_new_email( subject, target, content )
    @mail_content = content
    @target = target
    mail(to: target, subject: subject)
  end

  def thanks_contacting_email( name, target, content )
    @name = name
    @content = content
    mail(to: target, subject: 'Thank you very much for your message :: EVENT MAKER')
  end
end
