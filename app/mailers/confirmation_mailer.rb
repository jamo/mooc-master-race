class ConfirmationMailer < ActionMailer::Base
  default from: "mooc@cs.helsinki.fi"
  default host: "https://mooc-master.jamo.fi"

  def reserved(applicant, interview_time)
    title = "Ohjelmoinnin MOOC - haastatteluaikasi on varattu!"

    @applicant = applicant
    @interview_time = interview_time
    mail to: @applicant.email, subject: title, bcc: "jamo+mooc-master-sent@jamo.io"
  end
end
