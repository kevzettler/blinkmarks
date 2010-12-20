var QWKMRKS = function(){
	
	//If there no jquery on the page load the latest
	if(typeof jQuery == 'undefined'){
		var s=document.createElement('script');
		s.setAttribute('type', "text/javascript");
		s.setAttribute('src','http://jquery.com/src/jquery-latest.js');
		document.getElementsByTagName('body')[0].appendChild(s);
		s.onload = buildBar;
		s.onreadystatechange= function () {
			if (this.readyState == 'complete' || this.readyState == 'loaded'){
				buildBar();
			}
		}
 	}else{
		buildBar();
	}
		
		
	function buildBar(){
		jQuery.noConflict();
		jQuery(document).ready(function($){
			var $barDiv = $('<div></div>');
			$barDiv.css({
				width: '100%',
				height: '30px',
				border: 'none',
				padding: '0',
				margin: '0',
				position: 'fixed',
				top: "0px",
				left: "0px",
				display: 'none',
				'z-index': "9001",
				'background-color': '#FF8F82'
			});
			
			var $barIframe = $('<iframe/>');
			$barIframe.attr('src', "http://10.0.1.5:8888/bar.html");
			$barIframe.attr('width', "100%");
			$barIframe.attr('height', "30px");
			$barIframe.css({
				width: '90%',
				height: '100%',
				border: 'none',
				float: 'left'
			});
			
			var $closeBtn = $('<a href="#">Close X</a>');
			$closeBtn.css({float: 'right'});
			$closeBtn.click(function(){
				$barDiv.slideUp('fast', function(){
					$barDiv.remove();
				})
				return false;
			});
			
			$barDiv.prepend($barIframe);
			$barDiv.append($closeBtn);
			$('body').prepend($barDiv);
			$barDiv.slideDown('fast');
		});
	}
	
}();