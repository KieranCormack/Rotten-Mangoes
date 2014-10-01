class UserMailer < ActionMailer::Base
  default from: "rottenmangoes@mangoes.ca"

  def send_delete_email(email)
    mail(to: email, subject: 'You gone!')
  end

end
