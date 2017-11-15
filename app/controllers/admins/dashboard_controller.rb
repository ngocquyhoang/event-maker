class Admins::DashboardController < Admins::AccessController
  def index
  end

  def layout
  end

  def event_type
    @event_type = EventType.new

    @event_types = EventType.all
  end

  def create_event_type
    puts 'create'
  end

  def destroy_event_type
    puts 'destroy'
  end

  def payment
  end
end
