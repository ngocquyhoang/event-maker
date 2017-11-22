class Users::PaymentController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:hook]
  protect_from_forgery except: [:hook]

  def new
    amount = 0
    name = "test"
    @payment = Payment.new
    if params[:payment_method] = "paypal"
      case params[:status]
        when  "pro"
          amount = 100
          name = "Professional By Paypal"
        when  "pro_plus"
          amount = 1000
          name = "Professional Plus By Paypal"
      end
      redirect_to @payment.paypal_url amount, name, current_user.id, users_dashboard_index_path
    elsif params[:payment_method] = "baokim"
      case params[:status]
        when  "pro"
          amount = 10000
          name = "Professional By Baokim"
        when  "pro_plus"
          amount = 11000
          name = "Professional Plus By Baokim"
      end
      redirect_to @payment.baokim_url amount, name, current_user.id, users_dashboard_index_path
    end
  end

  def hook
    params.permit!
    status = params[:payment_status]
    user = User.find_by_id(params[:user_id])
    if status == "Completed"
      @payment = Payment.new
      item = params[:item_name]
      case item
        when "Professional By Paypal"
          @payment.update_attributes notification_params: params,
            status: status, transaction_id: params[:txn_id], user_id: params[:user_id],
            description: params[:item_name], purchased_at: params[:payment_date],
            amount: params[:payment_gross], payment_type: 0
          user.update_attributes acc_state: 1 if user
          flash[:success] = "Upgraded to Professional!!"
        when "Professional Plus By Paypal"
          @payment.update_attributes notification_params: params,
            status: status, transaction_id: params[:txn_id], user_id: params[:user_id],
            description: params[:item_name], purchased_at: params[:payment_date],
            amount: params[:payment_gross], payment_type: 0
          user.update_attributes acc_state: 2 if user
          flash[:success] = "Upgraded to Professional Plus!!"
      end
    end

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
end
