class MyMailer < ActionMailer::Base
  default from: 'no-reply@gmail.com'

  def sample_email(user)
    @user = user
    @token = AuthToken.issue_token(user_id: user.id, email: user.email)
    mail(to: @user.email, subject: 'Account Verification')
  end

  def forgot_email(user)
    @user = user
    mail(to: @user.email, subject: 'Reset Password')
  end

end
