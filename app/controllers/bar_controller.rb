class BarController < ApplicationController
  before_filter :authenticate_user!
  
  
  def index
    @blinkmark_url = params[:url]
    @blinkmark_title = params[:title]
    
    puts "omg current user or wot?__________"
    
    puts current_user.inspect
      
    @blinkmark = current_user.blinkmarks.find_by_url(params[:url])
  end
  
  def add
    current_user.blinkmarks << Blinkmark.new({
      :url => params[:url],
      :title => params[:title]
      #:tags => params[:tags]
    })
    
    respond_to do |format|
      if current_user.save
       format.html{redirect_to "/bar?url=" + URI.escape(params[:url]) +"&title=" + URI.escape(params[:title])}
       format.json{render :json => current_user, :status => :created}
      else
       format.json{render :json => current_user.errors, :status => :unprocessable_entity}
      end
    end
  end
  
  
  def remove
    @blinkmark =  current_user.blinkmarks.find_by_url(params[:url])
    
    respond_to do |format|
      if @blinkmark.delete
        format.json {render :json => @job, :status => 200}
      end
    end
  end
  
  def search
    @query = params[:query]
    #@results = current_user.blinkmarks.all(:conditions =>{'$where' => 'function(){ return this.title.match(/^'+@query+'/i) || this.url.match(/^'+@query+'/i)}'})
    @results = current_user.blinkmarks.search(@query).all
    
    puts "OMG SEARFING ___________"
    
    puts @results.inspect
    
    respond_to do |format|
      if @results
        format.json {render :json => @results, :status => 200}
      else
        format.json {render :json => [], :status => 200}
      end
    end
  end
  
  
end
