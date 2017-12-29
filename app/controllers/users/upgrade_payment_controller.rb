class Users::UpgradePaymentController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:hook]
  protect_from_forgery except: [:hook]

  require 'paypal-sdk-rest'
  include PayPal::SDK::REST

  PayPal::SDK::REST.set_config(
    :mode => "sandbox", # "sandbox" or "live"
    :client_id => "AehgGxH5CratvvhNtWnG6mPbZ1ctaae6PQcN5glLqAv_k_lB5y6IqUdkzTRJeQ46eJPvxFJjoiVbntLB",
    :client_secret => "EOIQvTN0c5k0u7sSksk0OE9h_arRSjCjZzN_N1zfTP9JavSR1oPuxppjHDaWb6X5DOihsaFgRCTbLm4C")

  def create
    if params[:type] == 'pro'
      price = '99.9'
      item_description = 'Event maker Professional package By Paypal'
    elsif params[:type] == 'plus'
      price = '199.9'
      item_description = 'Event maker Professional Plus package By Paypal'
    end
    @payment = Payment.new({
      :intent =>  "sale",
      :payer =>  {
       :payment_method =>  "paypal" },
      :redirect_urls => {
       :return_url => "https://zevent.date",
       :cancel_url => "https://zevent.date" },
      :transactions =>  [{
        :item_list => {
          :items => [{
            :name => "item",
            :sku => "item",
            :price => price,
            :currency => "USD",
            :quantity => 1 }]},
        :amount =>  {
          :total =>  price,
          :currency =>  "USD" },
        :description =>  item_description }]})

    if @payment.create
      @payment.id     # Payment Id
    else
      @payment.error  # Error Hash
    end

    respond_to do |f|
      f.json {render :json => @payment}
    end
  end

  def new
    amount = 0
    name = "test"
    @payment = UpgradePayment.new
    if params[:payment_method] == "baokim"
      case params[:status]
        when  "pro"
          amount = 2270000
          name = "Event maker Professional package By Baokim"
        when  "pro_plus"
          amount = 4540000
          name = "Event maker Professional Plus By Baokim"
      end
      redirect_to @payment.baokim_url amount, name, current_user.id, users_dashboard_index_path
    end
  end

  def hook
    params.permit!
    user = User.find_by_id(params[:user_id])

    if params[:transaction_status] == 4
      if params[order_id] == "Professional By Baokim"
        @payment.update_attributes notification_params: params,
          status: "Completed", transaction_id: params[:transaction_id], user_id: params[:user_id],
          description: params[:order_id], purchased_at: params[:created_on],
          amount: params[:total_amount], payment_type: 1
        user.update_attributes acc_state: 1 if user
        flash[:success] = "Upgraded to Professional!!"
      elsif params[order_id] == "Professional Plus By Baokim"
        @payment.update_attributes notification_params: params,
          status: "Completed", transaction_id: params[:transaction_id], user_id: params[:user_id],
          description: params[:order_id], purchased_at: params[:created_on],
          amount: params[:total_amount], payment_type: 1
        user.update_attributes acc_state: 2 if user
        flash[:success] = "Upgraded to Professional Plus!!"
      end
    end
    redirect_to user_path(user.username)
  end

  def paypal_return
    payment = Payment.find(params[:paymentID])

    if payment.execute( :payer_id => params[:payerID] )
      payment = UpgradePayment.new
      if params[:type] == 'pro'
        payment.update_attributes user_id: params[:user_id], amount: '100',
          purchased_at: Time.now, description: 'Upgraded to Professional',
          payment_type: 0, status: "Completed", transaction_id: params[:paymentID]
        user = User.find_by_id params[:user_id]
        user.update_attributes acc_state: 1
      elsif params[:type] == 'plus'
        payment.update_attributes user_id: params[:user_id], amount: '200',
          purchased_at: Time.now, description: 'Upgraded to Professional',
          payment_type: 0, status: "Completed", transaction_id: params[:paymentID]
        user = User.find_by_id params[:user_id]
        user.update_attributes acc_state: 2
      end

      # redirect_to user_path user.username, format: 'html'
    else
      payment.error # Error Hash
    end

    respond_to do |format|
      format.js {}
    end
  end
end
