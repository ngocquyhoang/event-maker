class HomeController < ApplicationController
  def index
    @message = Message.new
  end

  def new_message
    respond_to do |format|
      @message = Message.new(new_message_params)
      if @message.save
        @success = true
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
