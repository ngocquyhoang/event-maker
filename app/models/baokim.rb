class Baokim < ApplicationRecord
	def baokim_url amount, name, item_num, user_id, return_path
    key = "ae543c080ad91c23"
    url_can = "#{Rails.application.secrets.app_host}#{return_path}"
    url_suc = "#{Rails.application.secrets.app_host}/baokim?user_id=#{user_id}"
    data = "dev.baokim@bk.vn647#{name}#{item_num}#{amount}#{url_can}#{url_suc}"
    digest = OpenSSL::Digest.new('sha1')
    hmac = OpenSSL::HMAC.hexdigest(digest, key, data)
    checksum = hmac
    values = {
      business: "dev.baokim@bk.vn",
      merchant_id: 647,
      order_description: name,
      order_id: item_num,
      total_amount: amount,
      url_cancel: url_can,
      url_success: url_suc,
      checksum: checksum,
    }
    "https://sandbox.baokim.vn/payment/order/version11?" + values.to_query
  end
end
