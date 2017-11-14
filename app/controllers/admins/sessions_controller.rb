class Admins::SessionsController < Devise::SessionsController
  include AccessibleUser
  skip_before_action :check_user, only: :destroy
  
  layout :admin_layout

  protected
    def admin_layout
      "admins/layouts/application"
    end

    def after_sign_in_path_for(resource)
      admins_dashboard_index_path
    end
end
