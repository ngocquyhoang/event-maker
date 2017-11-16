class Admins::DashboardController < Admins::AccessController
  before_action :set_event_type, only: [:update_event_type, :destroy_event_type]

  def index
    @event_count = Event.count
    @message_count = Message.count
    @layout_count = Layout.count
    @user_count = User.count
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

  def messages
    @messages = Message.all.order('created_at DESC').limit(20)

    @reply = ReplyMessage.new()
  end

  def reply_messages
    @reply_messages = ReplyMessage.new(reply_message_params)

    respond_to do |format|
      if @reply_messages.save ? ( @save_success = true ) : ( @save_success = false )
        ContactMailer.reply_contact_email( @reply_messages.message, @reply_messages.content ).deliver
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

  def set_event_type
    @event_type = EventType.find( params[:id] )
  end
end
