class SignUpMailer < ActionMailer::Base
  default from: "mooc@cs.helsinki.fi"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sign_up_mailer.sign_up.subject
  #
  def sign_up(to, title, message)

    @message = message
    mail to: to, subject: title, bcc: "jamo+mooc-master-sent@jamo.io,avihavai@cs.helsinki.fi"
  end


  def tmc_not_linked(imported_user)
    @imported_user = imported_user

    title = "Tärkeää kevään 2016 MOOC yhteishausta"
    mail to: imported_user.email, subject: title, bcc: "jamo+mooc-master-sent@jamo.io,avihavai@cs.helsinki.fi"
  end
end
