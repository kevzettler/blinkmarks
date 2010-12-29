class BarController < ApplicationController
  before_filter :authenticate_user!
  
  
  def index
    @blinkmark_url = params[:url]
    @blinkmark_title = params[:title]
    
    puts "searching blinkmarks for________________"
    puts @blinkmark_url
    puts @blinkmark_title
    
    @blinkmark = Blinkmark.find_by_url(params[:url])
  end
  
  def add
    @new_fav = Blinkmark.new({
      :url => params[:url],
      :title => params[:title]
      #:tags => params[:tags]
    })
    
    respond_to do |format|
      if @new_fav.save
       format.html{redirect_to "/bar?url=" + URI.escape(params[:url]) +"&title=" + URI.escape(params[:title])}
       format.json{render :json => @new_fav, :status => :created}
      else
       format.json{render :json => @new_fav.errors, :status => :unprocessable_entity}
      end
    end
  end
  
  
  def remove
    @blinkmark = Blinkmark.find_by_url(params[:url])
    
    respond_to do |format|
      if @blinkmark.delete
        format.json {render :json => @job, :status => 200}
      end
    end
  end
  
  
end
