class QuestionaireMailer < ActionMailer::Base
  default from: "pradeep.brilliancetech@gmail.com"

  def mail_questionaire_to_patients(questionaire_url, current_user)
  	@questionaire_url = questionaire_url
  	@patients = current_user.patients

  	@patients.each do |patient|
  		mail(to: patient.email, subject: 'Questionaire From #{current_user.email}')
  	end
  end
end
