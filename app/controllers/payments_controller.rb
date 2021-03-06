class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    # @payments = Payment.all
    flash[:notice] = "Payment has been done successfully."
    redirect_to rapidfire_path
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  protect_from_forgery except: [:create]
  def create
    params.permit! # Permit all Paypal input params

    @user = User.find(params[:invoice].to_i)

    if params[:txn_type] == 'subscr_payment'
      status = params[:payment_status]

      if status == "Completed"
        @payment = Payment.new(:transaction_id => params[:txn_id], :payer_id => params[:payer_id], :amount => params[:payment_gross] ,:user_id=> params[:invoice])
        @payment.save
        @user.update_attributes(:payment_status => 1)
      else
        @user.destroy
      end
    end

    render nothing: true   

    # @payment = Payment.new(payment_params)

    # respond_to do |format|
    #   if @payment.save
    #     format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
    #     format.json { render :show, status: :created, location: @payment }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @payment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def redirect_to_paypal
  #   values = {
  #       business: "merchant.brilliancetech@gmail.com",
  #       upload: 1,
  #       no_shipping: 1,
  #       return: "#{Rails.application.secrets.app_host}/payments",
  #       notify_url: "#{Rails.application.secrets.app_host}/payments",
  #       invoice: rand(1..100),
  #       item_name: "Membership",
  #       cmd: "_xclick-subscriptions",
  #       a3: params['amount'],
  #       p3: 1,  # For 1 Month
  #       t3: "M",  # Monthly
  #       src: 1, # To Recurring
  #       sra: 1  # Reattempt When fails
  #   }

  #   redirect_to "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:token, :payer_id, :amount)
    end
end
