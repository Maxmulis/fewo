class TestMailer < ApplicationMailer
  def test_mail
    mail(to: "max.keller@hey.com", subject: "Hello")
  end

end
