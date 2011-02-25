class ExternalJS
  @@cache = ""

  def self.render
    b = Proc.new do
      if Rails.env == "staging" or Rails.env == "development"
        easyXDM = 'easyXDM.debug.js'
        root_url = "http://localhost:3000/"
      else
        easyXDM = 'easyXDM.min.js'
        root_url = "http://www.blinkmarks.com/"
      end
      
      binding
    end.call

    return ERB.new(File.read("#{RAILS_ROOT}/app/views/bar/external.html.erb")).result(b)
  end

  def self.update!
    @@cache = ExternalJS.render
  end
  
  def self.cache
    @@cache
  end
end

ExternalJS.update!