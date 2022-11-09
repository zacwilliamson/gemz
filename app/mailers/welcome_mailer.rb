class WelcomeMailer < ApplicationMailer
  def welcome_send(user)
    @user = user
    mail to: user.email, subject: 'Welcome to Fakebook', from: 'noreply@fakebook.onrender.com'
  end
end
