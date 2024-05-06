class UserMailer < ApplicationMailer
  default from: ENV['MAILJET.DEFAULT_FROM']

  def welcome_email(user)
    @user = user

    @url  = 'http://monsite.fr/login'

    mail(to: @user.email, subject: 'Bienvenue sur notre application !')
  end
end
