class Users::BaokimController < ApplicationController

 def new
    amount = 0
    name = "test"
    item_num = 0
    @baokim = Baokim.new
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
    redirect_to @baokim.baokim_url amount, name, item_num, current_user.id, users_dashboard_index_path
 end

 def create
   params.permit!
   status = params[:transaction_status]
   if status == 4
     @paypal = Paypal.new
     @paypal.update_attributes notification_params: params, status: status,
      transaction_id: params[:transaction_id], purchased_at: Time.now
     item = params[:order_id]
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
   redirect_to users_dashboard_index_path
 end
end
