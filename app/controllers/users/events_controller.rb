class Users::EventsController < ApplicationController
  include UsersHelper
  before_action :find_event, only: [:show]
  before_action :load_event, only: [:create]

  def show
  end

  def create
    event = Event.new
    event.update_attributes event_params

    respond_to do |format|
      format.js { render :file => "/users/dashboard/create_event.js.erb" }
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
end
