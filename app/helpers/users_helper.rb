module UsersHelper
  def get_district_list province
    distric_list = ActiveSupport::JSON.decode(File.read('databases/address_district.json'))
    distric_list_of_province = []
    distric_list.each do |district|
      distric_list_of_province << district if district['Ten_Tinh_Thanh_Pho'] == province
    end

    return distric_list_of_province
  end

  def get_commune_list(province, district)
    commune_list = ActiveSupport::JSON.decode(File.read('databases/address_commune.json'))
    commune_list_of_province = []
    commune_list.each do |commune|
      if commune['Ten_Tinh_Thanh_Pho'] == province && commune['Ten_Quan_Huyen'] == district
        commune_list_of_province << commune
      end
    end

    return commune_list_of_province
  end

  def get_job_list
    jobs = []
    File.readlines('databases/job_list.txt').map do |line|
      jobs << line.split("\r\n")[0]
    end

    return jobs
  end

  def get_like_dislike_list
    like_dislike_list = []
    File.readlines('databases/like_disklike_list.txt').map do |line|
      like_dislike_list << line.split("\r\n")[0]
    end
    like_dislike_list = like_dislike_list.uniq

    return like_dislike_list
  end

  def load_event
    @events = Event.where(user_id: current_user.id).order(id: :desc)
  end
end
