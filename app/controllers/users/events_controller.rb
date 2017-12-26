class Users::EventsController < Users::AccessController
  include UsersHelper
  before_action :find_event, only: [:show, :update, :edit, :destroy, :event_build]
  before_action :load_event, only: [:create]
  before_action :check_state, only: [:new, :create]

  def show
    redirect_to user_path(current_user.username) unless @event.user == current_user
    @cost_history = @event.cost_managements.order('created_at DESC')

    @new_cost_management = CostManagement.new
  end

  def new
    @event = Event.new
    @layouts = Layout.all
    @event_types = EventType.all

    @address_province_list = ActiveSupport::JSON.decode(File.read('databases/address_province.json'))
    @distric_list_of_province = get_district_list(@event.address_province)
    @commune_list_of_province = get_commune_list(@event.address_province, @event.address_district)
  end

  def create
    @event = Event.new event_params
    if @event.save
      flash[:success] = "Event was created!"
      @event.build_host
      redirect_to users_dashboard_index_path
    else
      flash[:error] = "Something went wrong please try again later!"
      redirect_to new_users_event_path
    end
  end

  def edit
    @layouts = Layout.all
    @event_types = EventType.all

    @address_province_list = ActiveSupport::JSON.decode(File.read('databases/address_province.json'))
    @distric_list_of_province = get_district_list(@event.address_province)
    @commune_list_of_province = get_commune_list(@event.address_province, @event.address_district)
  end

  def update
    if @event.update event_params
      @event.update_attributes(:is_builded => false)
      flash[:success] = "Event was successful updated!"
      redirect_to users_event_path(@event)
    else
      flash[:error] = "Something went wrong please try again later!"
      redirect_to edit_users_event_path(@event)
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = "Event was successful destroy!"
      redirect_to user_path(current_user.username)
    else
      flash[:error] = "Something went wrong please try again later!"
    end
  end

  def event_build
    unless @event.is_builded
      @event.build_website 
      @event.update_attributes(:is_builded => true)
    end
  end

  def check_event_slug_ajax
    is_valid = Event.new(name: 'BD', slug: params['event_slug'], user_id: 1, layout_id: 1, start_time: '01-12-2018 08:00', end_time: '01-12-2018 17:00', main_description: 'BD', address: 'BD', event_type_id: 1, address_commune: 'BD', address_district: 'BD', address_province: 'BD', expense: 2000, title_layout: 'BD', seo_keyword: 'BD').valid?
    render json: { 'is_valid': is_valid }
  end

  private
  def event_params
    params.require(:event).permit(:name, :title_layout, :slug, :user_id, :start_time, :end_time, :main_description, :sub_description, :layout_id, :event_type_id, :address, :address_commune, :address_district, :address_province, :est_amount_people, :expense, :seo_keyword, :google_form_url)
  end

  def find_event
    @event = Event.find_by id: params[:id]
  end

  def check_state
    if current_user.acc_state == "free"
      unless current_user.events.count < 1
        redirect_to user_path(current_user.username)
        flash[:error] = "Please upgrade your account to create more event"
      end
    elsif current_user.acc_state == "pro"
      unless current_user.events.count < 5
        redirect_to user_path(current_user.username)
        flash[:error] = "Please upgrade your account to create more event"
      end
    end
  end
end
