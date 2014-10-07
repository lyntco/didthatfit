class UserMailer < ActionMailer::Base
  default from: 'strawww@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'http://example.co'
    mail(to: @user.email, subject: 'Welcome to Did That Fit.me')
  end
end
