class BlinkmarksController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :view]
  
  def create
    blinkmark = Blinkmark.new({
      :user_id => current_user.id,
      :url => params[:url],
      :title => params[:title]
    })
    
    respond_to do |format|
      if blinkmark.save
       format.html{redirect_to "/bar?url=" + URI.escape(params[:url]) +"&title=" + URI.escape(params[:title])}
       format.json{render :json => current_user.blinkmarks, :status => :created}
      else
       format.json{render :json => current_user.errors, :status => :unprocessable_entity}
      end
    end
  end
  
  
  def delete
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
    puts @results.inspect
    
    respond_to do |format|
      if @results
        format.json {render :json => @results, :status => 200}
      else
        format.json {render :json => [], :status => 200}
      end
    end
  end
  
  
  def add_tag
    tags = params[:tags].split(",").collect!{|x| x.strip}
    blinkmark = current_user.blinkmarks.find_by_url(params[:url])
    new_tags = tags - blinkmark.tags
    blinkmark.tags.concat(tags)
    blinkmark.tags = blinkmark.tags.uniq

    respond_to do |format|
      if blinkmark.save
          format.html{redirect_to "/bar?url=" + URI.escape(params[:url]) +"&title=" + URI.escape(params[:title])}
          format.json{render :json => new_tags.uniq, :status => :created}
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
    blinkmark.tags = tags
    
    respond_to do |format|
      if blinkmark.save
          format.html{redirect_to "/bar?url=" + URI.escape(params[:url]) +"&title=" + URI.escape(params[:title])}
          format.json{render :json => current_user.blinkmarks, :status => :created}
        else
          format.json{render :json => current_user.errors, :status => :unprocessable_entity}
      end
    end
  end
  
end