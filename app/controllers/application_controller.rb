class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  
  delegate :allow?, to: :current_permission
  helper_method :allow?
  
  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?
  
private
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_permission
    @current_permission ||= Permission.new(current_user)
  end
  
  #overwritten in subclass for controllers
  def current_resource
    nil
  end

  def my_paginate(association, next_id_param)
    paginator = ElementPaginator.new(association, params[next_id_param])
    paginator.next_id_parameter = next_id_param
    paginator
  end
  
  def authorize
    if current_permission.allow?(params[:controller], params[:action], current_resource)
      current_permission.permit_params! params
    else
      redirect_to root_url, alert: "Not authorized."
    end
  end
end
