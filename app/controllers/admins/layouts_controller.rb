class Admins::LayoutsController < Admins::AccessController
  def create
    layout = Layout.new
    if layout.update_attributes layout_params
      flash[:success] = "Layout created!!"
    else
      flash[:success] = "Something Wrong!!"
    end

    respond_to do |format|
      format.js { render :file => "/admins/dashboard/create_layout.js.erb" }
    end
  end

  private
  def layout_params
    params.require(:layout).permit :title, :html, :start_time, :end_time,
      :main_description, :sub_description, :event_type_id, :address
  end
end
