var blinkmarks = function(){
	
	//Function for building the bar	
	function buildBar(){			
		if(jQuery('div#blinkmarks').length > 0){ return false;}

		jQuery.noConflict();
		jQuery(document).ready(function($){
			var $barDiv = $('<div id="blinkmarks"></div>');
			$barDiv.css({
				width: '100%',
				height: '30px',
				border: 'none',
				padding: '0',
				margin: '0',
				position: 'fixed',
				'padding-top': "10px",
				top: "0px",
				left: "0px",
				display: 'none',
				'z-index': "9001",
				'background-color': '#FF8F82'
			});
	
			var $barIframe = $('<iframe/>', {
			'src': "http://0.0.0.0:3000/bar?title="+encodeURIComponent(window.document.title)+"&url="+encodeURIComponent(window.location.href),
			'name': window.location.href+"||"+window.document.title,
			'width': "100%",
			'height': "30px",
			"scrolling": "no",
			"frameborder": "0",
			"padding-left": "10px"
			});
			
			$barIframe.css({
				width: '90%',
				height: '100%',
				border: 'none',
				float: 'left'
			});
	
			var $closeBtn = $('<a href="#">X</a>');
			$closeBtn.css({
				float: 'right',
				"padding-right": "10px"
			});
			$closeBtn.click(function(){
				$barDiv.slideUp('fast', function(){
					$barDiv.remove();
				});
				return false;
			});
	
			$barDiv.prepend($barIframe);
			$barDiv.append($closeBtn);
			$('body').prepend($barDiv);
			$barDiv.slideDown('fast');
		});
	}
		
	//If there is no jquery on the page load the latest
	if(typeof jQuery == 'undefined'){
		var s=document.createElement('script');
		s.setAttribute('type', "text/javascript");
		s.setAttribute('src','http://jquery.com/src/jquery-latest.min.js');
		document.getElementsByTagName('body')[0].appendChild(s);
		s.onload = buildBar;
		s.onreadystatechange = function () {
			if (this.readyState == 'complete' || this.readyState == 'loaded'){
				buildBar();
			}
		};
	}else{
		buildBar();
	}		
	
	//public api
	return{ 
		buildBar : buildBar, 
		buildList : function(results_array){
			var $linkList = $("<ul/>");
			$linkList.css({
				position: 'absolute',
				top: '0px',
				left: '0px',
				'z-index': "9001"
			});
			for(var i=0; i<results_array.length; i++){
				$linkList.append('<li><a href="'+results_array[i].url+'">"'+results_array[i].title+'"</a></li>');
			}
			$('body').append($linkList);
			
		}
	};
}();