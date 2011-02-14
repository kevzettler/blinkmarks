module ApplicationHelper
  
  def bookmarklet
    "javascript:(function(){if(typeof blinkmarks == 'object'){blinkmarks.buildBar()}else{var qm = document.createElement('script');qm.type = 'text/javascript';qm.async = true;qm.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + '"+bar_external_url[7, bar_external_url.length - 7]+"';var b = document.getElementsByTagName('body')[0]; b.appendChild(qm);}})();"
  end
end
