class BarController < ApplicationController
  before_filter :authenticate_user!, :except => [:external, :frame]
  
  layout "bar"
  
  def index
    puts params.inspect
    @blinkmark_url = params[:url]
    @blinkmark_title = params[:title]
    @blinkmark = current_user.blinkmarks.find_by_url(params[:url])
    puts @blinkmark.inspect
  end
  
  def add
    current_user.blinkmarks << Blinkmark.new({
      :url => params[:url],
      :title => params[:title]
    })
    
    respond_to do |format|
      if current_user.save
       format.html{redirect_to "/bar?url=" + URI.escape(params[:url]) +"&title=" + URI.escape(params[:title])}
       format.json{render :json => current_user.blinkmarks, :status => :created}
      else
       format.json{render :json => current_user.errors, :status => :unprocessable_entity}
      end
    end
  end
  
  
  def tag
    tags = params[:tags].split(",").collect!{|x| x.strip}
    blinkmark = current_user.blinkmarks.find_by_url(params[:url])
    blinkmark.tags.concat(tags)
    
    respond_to do |format|
      if blinkmark.save
          format.html{redirect_to "/bar?url=" + URI.escape(params[:url]) +"&title=" + URI.escape(params[:title])}
          format.json{render :json => current_user.blinkmarks, :status => :created}
        else
          format.json{render :json => current_user.errors, :status => :unprocessable_entity}
      end
    end
  end
  
  def remove_tag
    tag = params[:tag]
    blinkmark = current_user.blinkmarks.find_by_url(params[:url])
    tags = blinkmark.tags
    tags.delete(tag)
    puts "blinkmark before drop"
    puts blinkmark.inspect
    puts blinkmark.tags.index(tag)
    puts blinkmark.tags.inspect
    blinkmark.tags = tags
    
    puts "blinkmark after drop"
    puts blinkmark.inspect
    
    respond_to do |format|
      if blinkmark.save
          format.html{redirect_to "/bar?url=" + URI.escape(params[:url]) +"&title=" + URI.escape(params[:title])}
          format.json{render :json => current_user.blinkmarks, :status => :created}
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
  
  def external
    response.headers["Last-Modified"] = Time.now.httpdate
    response.headers["Expires"] = 0
    # HTTP 1.0
    response.headers["Pragma"] = "no-cache"
    # HTTP 1.1 'pre-check=0, post-check=0' (IE specific)
    response.headers["Cache-Control"] = 'no-store, no-cache, must-revalidate, max-age=0, pre-check=0, post-check=0'
    render :action => 'external', :layout => false, :content_type => 'text/javascript'
  end
  
  def frame
    @pass_url = params[:url]
    @pass_title = params[:title]
    render :action => 'frame', :layout => false
  end
  
end
