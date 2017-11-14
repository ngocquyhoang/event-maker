class Users::SessionsController < Devise::SessionsController
  include AccessibleAdmin
  skip_before_action :check_admin, only: :destroy

  layout :user_layout

  protected
    def user_layout
      "users/layouts/application"
    end

    def after_sign_in_path_for(resource)
      users_dashboard_index_path
    end

    def after_sign_up_path_for(resource)
      users_dashboard_index_path
    end
end
