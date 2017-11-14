class Users::PaypalController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:hook]
  protect_from_forgery except: [:hook]

  def new
    amount = 0
    name = "test"
    item_num = 0
    @paypal = Paypal.new
    case params[:status]
      when  "pro"
        amount = 100
        name = "Upgrade account to Professional"
        item_num = 1
      when  "pro_plus"
        amount = 1000
        name = "Upgrade account to Professional Plus"
        item_num = 2
    end
    redirect_to @paypal.paypal_url amount, name, item_num, current_user.id, users_dashboard_index_path
  end

  def hook
    params.permit!
    status = params[:payment_status]
    if status == "Completed"
      @paypal = Paypal.new
      @paypal.update_attributes notification_params: params, status: status,
        transaction_id: params[:txn_id], purchased_at: Time.now
      item = params[:item_number]
      user = User.find_by_id(params[:user_id])
      case item
        when "1"
          user.update_attributes acc_state: 1 if user
          flash[:success] = "Upgraded to Professional!!"
        when "2"
          user.update_attributes acc_state: 2 if user
          flash[:success] = "Upgraded to Professional Plus!!"
      end
    end
    render "/users/dashboard/paypal.html.erb"
  end
end
