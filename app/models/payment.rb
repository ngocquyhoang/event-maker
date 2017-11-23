class Payment < ApplicationRecord
  belongs_to :user
  enum payment_type: [:paypal, :baokim]

  def paypal_url amount, name, user_id, return_path
    values = {
      business: "zevent.date@gmail.com",
      cmd: "_xclick",
      upload: "1",
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: amount,
      item_name: name,
      quantity: "1",
      notify_url: "#{Rails.application.secrets.app_host}/hook?user_id=#{user_id}"
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  def baokim_url amount, name, user_id, return_path
    key = "d9486353f04c1866"
    site_id = 31632
    business_mail = "zevent.date@gmail.com"
    url_can = "#{Rails.application.secrets.app_host}#{return_path}"
    url_suc = "#{Rails.application.secrets.app_host}/hook?user_id=#{user_id}"
    data = "#{business_mail}#{site_id}#{name}#{amount}#{url_can}#{url_suc}"
    digest = OpenSSL::Digest.new('sha1')
    hmac = OpenSSL::HMAC.hexdigest(digest, key, data)
    checksum = hmac
    values = {
      business: business_mail,
      merchant_id: site_id,
      order_id: name,
      total_amount: amount,
      url_cancel: url_can,
      url_success: url_suc,
      checksum: checksum,
    }
    "https://baokim.vn/payment/order/version11?" + values.to_query
  end
end
