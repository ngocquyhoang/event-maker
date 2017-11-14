class Users::EventsController < Users::AccessController
  include UsersHelper
  before_action :find_event, only: [:show, :update]
  before_action :load_event, only: [:create]
  before_action :load_cost, only: [:show]

  def show
  end

  def create
    event = Event.new
    if event.update_attributes event_params
      flash[:success] = "Event created!!"
    else
      flash[:danger] = "Something Wrong!!"
    end

    respond_to do |format|
      format.js { render :file => "/users/dashboard/create_event.js.erb" }
    end
  end

  def update
    if @event.update_attributes event_params
      flash[:success] = "Event edited!!"
    else
      find_event
      flash[:danger] = "Something Wrong!!"
    end
  end

  private
  def event_params
    params.require(:event).permit :name, :title_layout, :slug, :user_id, :start_time,
      :end_time, :main_description, :sub_description, :layout_id, :event_type_id,
      :address, :scale, :est_amount_people, :expense, :seo_keyword, :use_form,
      :google_form_url
  end

  def find_event
    @event = Event.find_by id: params[:id]
  end

  def load_cost
    @cost_log = CostManagement.where(event_id: params[:id]).order(id: :desc)
  end
end
