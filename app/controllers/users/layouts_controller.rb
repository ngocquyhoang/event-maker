class Users::LayoutsController < Users::AccessController
  def index
    @layouts = Layout.all
    @types = EventType.all
  end
end
