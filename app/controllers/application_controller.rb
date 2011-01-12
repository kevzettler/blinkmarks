class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource
  
  def index
    render :action => 'index', :layout => false
  end
  
  def layout_by_resource
      if devise_controller? or bar_controller?
        "bar"
    end
  end
end
