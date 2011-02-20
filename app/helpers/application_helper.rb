module ApplicationHelper
  
  def bookmarklet
    string ="javascript:(function(){
                    if(typeof blinkmarks === 'object'){
                      blinkmarks.buildBar();
                    }else{
                      var qm = document.createElement('script'),
                      rn=Math.floor(Math.random()*5),
                      ts=Date.UTC(new Date().getUTCFullYear(), new Date().getUTCMonth(), new Date().getUTCDate(), new Date().getUTCHours(), new Date().getUTCMinutes(), new Date().getUTCSeconds());
                      qm.type = 'text/javascript';
                      qm.async = true;
                      qm.src = ('https:' === document.location.protocol ? 'https://' : 'http://') + '"+bar_external_url[7, bar_external_url.length - 7]+"' + (rn === 4 ? '?cb='+ts : '');
                      var b = document.getElementsByTagName('body')[0]; 
                      b.appendChild(qm);
                    }
                }());"
    return string.gsub( /([\r\n\f\t](\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s))/mi, "" )
  end
end
