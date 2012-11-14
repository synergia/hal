class ApplicationController < ActionController::Base
  protect_from_forgery

  BLOCKED_ACTIONS = {
    "categories"  => ["new", "create", "edit", "update", "destroy"],
    "items"       => ["new", "create", "edit", "update", "destroy"],
    "orders"      => ["index", "edit", "update", "accept", "reject"],
    "users"       => ["new", "create", "edit", "update", "destroy"],
    "stuffs"      => ["new", "create", "edit", "update", "destroy"]
  }

  def prevent_access
    unless current_user.admin?
      actions = BLOCKED_ACTIONS[params[:controller].to_s]
      if actions && actions.include?(params[:action].to_s)
        redirect_to "/" and return false
      end
    end
  end
end
