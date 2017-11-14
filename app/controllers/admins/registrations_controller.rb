class Admins::RegistrationsController < Devise::RegistrationsController
  include AccessibleUser
  skip_before_action :check_user, only: :destroy
  
  layout :admin_layout

  def new
    redirect_to new_session_path(resource_name)
  end

  def create
    puts "Can't create sign up Admin"
  end

  def destroy
    puts "Can't delete sign up Admin"
  end

  protected
  def admin_layout
    "admins/layouts/application"
  end
end
