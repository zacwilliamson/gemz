class WelcomeMailer < ApplicationMailer
  def welcome_send(user)
    @user = user
    mail to: user.email, subject: 'Welcome to Gemz', from: 'gemzonrender@gmail.com'
  end
end
