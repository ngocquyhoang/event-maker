class HomeController < ApplicationController
  def index
    @message = Message.new
    @layouts = Layout.all.order('created_at DESC').limit(3)
  end

  def layouts
    @layouts = Layout.all

    @layout_type = []
    EventType.all.each do | type |
      @layout_type << type.label
    end
  end

  def new_message
    respond_to do |format|
      @message = Message.new(new_message_params)
      if @message.save
        @success = true
        ContactMailer.thanks_contacting_email( @message.name, @message.email, @message.message ).deliver
      else
        @success = false
      end
      format.js {}
    end
  end

  def new_message_params
    params.require(:message).permit(:name, :email, :message)
  end
end
