class UserMailer < ActionMailer::Base
  default from: "saravanan@example.com"

  def test_email()
    mail(to: "psaravanan11@gmail.com", subject: 'test gem Email')
  end

end
