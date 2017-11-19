class Admins::DashboardController < Admins::AccessController
  before_action :set_event_type, only: [:update_event_type, :destroy_event_type]

  # DASHBOARD BLOCK #################################

  def index
    @event_count = Event.count
    @message_count = Message.count
    @layout_count = Layout.count
    @user_count = User.count
  end

  # LAYOUT BLOCK ####################################

  def layout
    @new_layout = Layout.new

    @layouts = Layout.all

    @event_types = []

    EventType.all.each do |type|
      @event_types << type.label
    end
  end

  def create_layout
    new_layout_params = layout_params.to_h
    new_layout_params[:event_types].shift
    new_layout_params[:event_types] = new_layout_params[:event_types].join(" / ")

    @layout = Layout.new( new_layout_params )

    respond_to do |format|
      @layout.save ? ( @save_success = true ) : ( @save_success = false )
      @layout.reload

      format.js {}
    end
  end

  # EVENT TYPE BLOCK ################################

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

  # PAYMENT BLOCK ###################################

  def payment
  end

  # MESSAGES BLOCK ##################################

  def messages
    @messages = Message.all.order('created_at DESC')
    @new_email = AdminEmail.new

    @reply = ReplyMessage.new()
  end

  def reply_messages
    @reply_messages = ReplyMessage.new(reply_message_params)

    respond_to do |format|
      if @reply_messages.save
        ContactMailer.reply_contact_email( @reply_messages.message, @reply_messages.content ).deliver
        @save_success = true
      else
        @save_success = false
      end
      format.js {}
    end
  end

  def new_email
    @new_message = AdminEmail.new(new_message_params)

    respond_to do |format|
      if @new_message.save
        ContactMailer.send_new_email( @new_message.subject, @new_message.to_email, @new_message.email_body ).deliver
        @save_success = true
      else
        @save_success = false
      end
      format.js {}
    end
  end

  private

  def event_type_params
    params.require(:event_type).permit(:label)
  end

  def reply_message_params
    params.require(:reply_message).permit(:content, :message_id)
  end

  def new_message_params
    params.require(:admin_email).permit(:to_email, :subject, :email_body)
  end

  def layout_params
    params.require(:layout).permit(:name, { :event_types => [] }, :featured_image, :html, :css, :javascript)
  end

  def set_event_type
    @event_type = EventType.find( params[:id] )
  end
end
