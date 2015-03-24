class QuestionaireMailer < ActionMailer::Base
  default from: "pradeep.brilliancetech@gmail.com"

  def mail_questionaire_to_patients(questionaire_url, patient_email)
  	@questionaire_url = questionaire_url
  	mail(to: patient_email, subject: 'Questionaire From #{current_user.email}')
  end
end
