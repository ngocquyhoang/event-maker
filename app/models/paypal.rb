class Paypal < ApplicationRecord
  def paypal_url amount, name, item_num, user_id, return_path
    values = {
      business: "fnaticrc.carn-facilitator@gmail.com",
      cmd: "_xclick",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: amount,
      item_name: name,
      item_number: item_num,
      quantity: "1",
      notify_url: "#{Rails.application.secrets.app_host}/hook?user_id=#{user_id}"
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
