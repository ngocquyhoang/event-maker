class Admins::DashboardController < Admins::AccessController
  before_action :set_event_type, only: [:update_event_type, :destroy_event_type]

  def index
  end

  def layout
  end

  def event_type
    @event_type = EventType.new

    @event_types = EventType.all.order('created_at DESC')
  end

  def create_event_type
    @event_type = EventType.new( event_type_params )

    respond_to do |format|
      @event_type.save ? ( @save_success = true ) : ( @save_success = false )
      format.js {}
    end
  end

  def update_event_type
    respond_to do |format|
      @event_type.update( event_type_params ) ? ( @update_success = true ) : ( @update_success = false )
      @event_type.reload
      format.js {}
    end
  end

  def destroy_event_type
    respond_to do |format|
      @event_type.destroy
      format.js {}
    end
  end

  def payment
  end

  private

  def event_type_params
    params.require(:event_type).permit(:label)
  end

  def set_event_type
    @event_type = EventType.find( params[:id] )
  end
end
