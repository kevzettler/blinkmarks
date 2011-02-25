class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource
  
  def index
    render :action => 'index'
  end
  
  def layout_by_resource
      if devise_controller?
        "bar"
      else
        controller_name
      end
  end
end
