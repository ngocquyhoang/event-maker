module ApplicationHelper
  require 'unicode_utils'

  def avatar_for user
    if user.avatar?
      cl_image_tag(@user.avatar.full_public_id, :transformation=>[{:width=>400, :height=>400, :gravity=>"auto", :radius=>"max", :crop=>"crop"}, {:width=>200, :crop=>"scale"}])
    else
      if user.gender == "male"
        image_tag "user-avatar-male.png", class: "img-user-avatar"
      elsif user.gender == "female"
        image_tag "user-avatar-female.png", class: "img-user-avatar"
      else
        image_tag "user-avatar-default.png", class: "img-user-avatar"
      end
    end
  end

  def get_age dob
    return nil unless dob
    now = Time.now
    now.year - dob.year - ( dob.to_time.change(:year => now.year) > now ? 1 : 0 )
  end

  def address_for user
    address = []
    address << user.address_commune if user.address_commune?
    address << user.address_district if user.address_district?
    address << user.address_province if user.address_province?
    return address.join(' - ')
  end

  def load_event_type_label layout
    if layout.event_type_id.nil?
      "other"
    else
      EventType.find_by_id(layout.event_type_id).label
    end
  end

  def get_slug string
    slug_return = UnicodeUtils.downcase(string, :tr).gsub(/[()-,. @*&$#^!']/, '')
    return slug_return
  end

  def get_income event
    income = 0
    event.cost_managements.each do |transaction| 
      if transaction.cost_type == 'income'
        income += transaction.amount
      end
    end  

    return income 
  end

  def get_expense event
    expense = 0
    event.cost_managements.each do |transaction| 
      if transaction.cost_type == 'cost'
        expense += transaction.amount
      end
    end  

    return expense 
  end  
end
