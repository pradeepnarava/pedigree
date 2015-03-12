class PagesController < ApplicationController
  
  def membership_not_paid
  	
  end
  
  def send_questionaire
  end

  def email_questionaire
    QuestionaireMailer.mail_questionaire_to_patients(params[:questionaire_url], current_user).deliver
  	flash[:notice] = "Questionaire has been sent."
  	redirect_to pages_send_questionaire_path
  end

  def generate_pedigree
    @question_group = Rapidfire::QuestionGroup.find(params[:id])
    @question_group_results =
      Rapidfire::QuestionGroupResults.new(question_group: @question_group).extract

    render :pdf => "pedigree"
  end
end
