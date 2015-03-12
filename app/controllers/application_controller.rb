class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	# Current User for Questionaire
 #  	def current_user
 #  		@current_user ||= User.find(session[:user_id])
	# end

	# Current User for Questionaire
	def can_administer?
  		current_user.try(:role) == "clinic"
	end

	def after_sign_in_path_for(resource_or_scope)
		if admin_user_signed_in?
			admin_dashboard_path
		else
			if current_user.payment_status == 1
				rapidfire_path	
			else
				destroy_user_session_path
			end			
      	end
	end

	# def after_sign_out_path_for(resource_or_scope)
	#   	question_groups_path
	# end
end
