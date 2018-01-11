require 'unicode_utils'

class Event < ApplicationRecord
  belongs_to :user
  belongs_to :event_type
  belongs_to :layout
  has_many :cost_managements

  validate :start_time_validation
  validate :end_time_validation

  validates :slug, uniqueness: true, presence: true, length: { in: 3..12 }
  validates :name, presence: true
  validates :user_id, presence: true
  validates :layout_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :main_description, presence: true
  validates :address, presence: true
  validates :event_type_id, presence: true
  validates :address_commune, presence: true
  validates :address_district, presence: true
  validates :address_province, presence: true
  validates :expense, presence: true
  validates :title_layout, presence: true
  validates :seo_keyword, presence: true

  before_save :clean_slug

  def start_time_validation
    if self.start_time.present? && self.start_time < Date.today
      errors.add(:start_time, "can't be in the past")
    end
  end

  def end_time_validation
    if self.end_time.present?
      if self.end_time < Date.today
        errors.add(:start_time, "can't be in the past")
      elsif self.start_time.present? && self.end_time < self.start_time
        errors.add(:start_time, "can't be less than start date")
      end
    end
  end

  def clean_slug
    self.slug = UnicodeUtils.downcase("#{self.slug}", :tr).gsub(/[()-,. @*&$#^!']/, '')
  end

  def build_host
    create_host_cmd = "sudo virtualhost create " + self.slug + ".zevent.date"
    system(create_host_cmd)
    create_ssl_cmd = "sudo certbot --authenticator webroot --webroot-path /var/www/zevent/" + self.slug + "zeventdate --installer apache --redirect -d " + self.slug + ".zevent.date"
    system(create_ssl_cmd)

    create_html_file_cmd = "sudo touch /var/www/zevent/" + self.slug + "zeventdate/index.html"
    create_css_file_cmd = "sudo touch /var/www/zevent/" + self.slug + "zeventdate/styles.css"
    create_js_file_cmd = "sudo touch /var/www/zevent/" + self.slug + "zeventdate/applications.js"
    system(create_html_file_cmd)
    system(create_css_file_cmd)
    system(create_js_file_cmd)

    chmod_cmd = "sudo chmod -R 777 /var/www/zevent/" + self.slug + "zeventdate"
    system(chmod_cmd)
  end

  def build_website
    html_code = self.layout.html.gsub( "zevent_name", self.name )
    html_code.gsub!( "zevent_slug", self.slug )
    html_code.gsub!( "zevent_start_time", self.start_time.strftime("%I:%M%p %d %B %Y") )
    html_code.gsub!( "zevent_end_time", self.end_time.strftime("%I:%M%p %d %B %Y") )
    html_code.gsub!( "zevent_main_description", self.main_description )
    html_code.gsub!( "zevent_sub_description", self.sub_description )
    html_code.gsub!( "zevent_address", self.address + self.address_commune + self.address_district + self.address_province )
    html_code.gsub!( "zevent_title_layout", self.title_layout )
    html_code.gsub!( "zevent_seo_keyword", self.seo_keyword )
    html_code.gsub!( "zevent_google_form_url", self.google_form_url )
    html_code.gsub!( "zevent_user_email", self.user.email )
    css_code = self.layout.css
    javascript_code = self.layout.javascript
    
    File.write( "/var/www/zevent/#{ self.slug }zeventdate/index.html", html_code )
    File.write( "/var/www/zevent/#{ self.slug }zeventdate/styles.css", css_code )
    File.write( "/var/www/zevent/#{ self.slug }zeventdate/applications.js", javascript_code )
  end
end
