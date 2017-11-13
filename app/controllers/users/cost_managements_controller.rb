class Users::CostManagementsController < Users::AccessController
  before_action :load_cost, only: [:create]

  def create
    log = CostManagement.new
    log.update_attributes cost_params

    respond_to do |format|
      format.js { render file: "/users/events/create_cost_management.js.erb" }
    end
  end

  private
  def cost_params
    params.require(:cost_management).permit :cost_type, :amount, :note, :user_id, :event_id
  end

  def load_cost
    @cost_log = CostManagement.where(event_id: params[:cost_management][:event_id]).order(id: :desc)
  end
end
