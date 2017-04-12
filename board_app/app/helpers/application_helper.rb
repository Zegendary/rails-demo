module ApplicationHelper
  def authorize
    login_then_redirect_to request.path unless current_user
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


end
