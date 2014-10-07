class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url = 'http://example.co'
    mail(to: @user.email, subject: 'Welcome to Did That Fit.me')
  end
end
