class Users::DashboardController < Users::AccessController
  include UsersHelper
  before_action :load_event, only: [:index]

  def index; end
end
