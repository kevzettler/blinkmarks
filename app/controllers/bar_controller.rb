class BarController < ApplicationController
  before_filter :authenticate_user!, :except => [:external, :frame]
  
  layout "bar"
  
  def index
    @blinkmark_url = params[:url]
    @blinkmark_title = params[:title]
    @blinkmark = current_user.blinkmarks.find_by_url(params[:url])
  end
  

  def external

    # response.headers["Last-Modified"] = Time.now.httpdate.to_s
    # response.headers["Expires"] = 0.to_s
    # # HTTP 1.0
    # response.headers["Pragma"] = "no-cache"
    # # HTTP 1.1 'pre-check=0, post-check=0' (IE specific)
    # response.headers["Cache-Control"] = 'no-store, no-cache, must-revalidate, max-age=0, pre-check=0, post-check=0'
    # response.headers['Content-type'] = 'application/javascript; charset=utf-8'
    # 
    render :text => ExternalJS.cache, :layout => false
  end
  
  def frame
    @pass_url = params[:url]
    @pass_title = params[:title]
    render :action => 'frame', :layout => false
  end
  
end
