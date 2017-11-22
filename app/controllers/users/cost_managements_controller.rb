class Users::CostManagementsController < Users::AccessController
  def create
    @event = Event.find(params[:id])
    if @event.user == current_user 
      @cost_management = CostManagement.new ( cost_management_params )

      respond_to do |format|
        @cost_management.save ? ( @create_success = true ) : ( @create_success = false )
        format.js {}
      end
    end
  end

  private
    def cost_management_params
      params.require(:cost_management).permit( :cost_type, :amount, :note, :user_id, :event_id )
    end
end
