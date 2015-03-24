class PagesController < ApplicationController
  
  def membership_not_paid
  	
  end
  
  def send_questionaire
  end

  def email_questionaire
    @patient_emails = params[:patient_emails].split(",")
    @invalid_emails = ""
    @questionaire_url = params[:questionaire_url]
    

    @patient_emails.each do |patient_email|
      if valid_email?(patient_email)
        @questionaire_url << "&email=#{patient_email}&cid=#{current_user.id}"
        QuestionaireMailer.mail_questionaire_to_patients(@questionaire_url, patient_email).deliver
      else
        @invalid_emails << patient_email << ","
      end
    end

  	flash[:notice] = "Questionaire has been sent"
    unless @invalid_emails.blank?
      flash[:notice] << " for correct E-mails. Failed to sent for Wrong Emails. They are : #{@invalid_emails.chomp(',')}"
    end

  	redirect_to pages_send_questionaire_path
  end

  def generate_pedigree
    @question_group = Rapidfire::QuestionGroup.find(params[:id])
    @question_group_results =
      Rapidfire::QuestionGroupResults.new(question_group: @question_group).extract

    render :pdf => "pedigree"
  end

  private

  def valid_email?(email)
    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid_email_regex)
  end
end
