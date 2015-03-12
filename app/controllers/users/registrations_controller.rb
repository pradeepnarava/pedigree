class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    unless Membership.where(:id=>params[:id]).empty?
      super
    else
      redirect_to root_path
    end
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :membership_id)}
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    values = {
        business: "business.brilliancetech@gmail.com",
        upload: 1,
        no_shipping: 1,
        # return: "#{Rails.application.secrets.app_host}/payments",
        return: "http://familypedigree.herokuapp.com/payments",
        # notify_url: "#{Rails.application.secrets.app_host}/payments",
        notify_url: "http://familypedigree.herokuapp.com/payments",
        invoice: resource.id,
        item_name: "Membership",
        cmd: "_xclick-subscriptions",
        a3: resource.membership.fee_amount,
        p3: 1,  # For 1 Month
        t3: "M",  # Monthly
        src: 1, # To Recurring
        sra: 1  # Reattempt When fails
    }

    # return "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
    return "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    # super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
