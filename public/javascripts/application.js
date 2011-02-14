$(document).ready(function(){
	if(typeof window.console !== 'object'){
		window.console = {log: function(){return false;}};
	}
	
	var rpc = window.parent.rpc;
	$('.autobox').autobox();
	
	$('.add').live('click', function(){
		var $this = $(this);

		$.ajax({
			url: "/bar/add",
			type: "post",
			data: {
				url : window.name.split("||")[0],
				title : window.name.split("||")[1]
			},
			error : function(){ console.log('uh oh'); },
			success : function(data){
				$this.text('Remove from favorites');
				$this.removeClass('add');
				$this.addClass('remove');
				var $form = $('form.tag_form');
				console.log("showing tag form!!!", $form);
				$form.show();
			},
			dataType: 'json'
		});
		return false;
	});
	
	$('.remove').live('click', function(){
		var $this = $(this);
		$.ajax({
			url : "/bar/remove",
			type: "post",
			data: {
				url: window.name.split("||")[0],
				title : window.name.split("||")[1]
			},
			success :function(){
				$this.text('Add to favorites');
				$this.removeClass('remove');
				$this.addClass('add');
				$this.parent().find('form.tag_form').remove();
			},
			dataType: 'json'
		});
		return false;
	});


function typeAheadCall(e){
	console.log("type ahead call", e, e.keyCode);
	if(e.keyCode === 40 || e.keyCode === 38){
		//do not rebuild on up down
		return false;
	}
	
	var $this = $(this);
	$this.addClass('loading');
	$.ajax({
		url: "/bar/search",
		type: "post",
		data: {
			query: $this.val()
		},
		success: function(data){
			rpc.buildList(data);
			$this.removeClass('loading');
		},
		error: function(){
			console.log("key up broke");
			$this.removeClass('loading');
		},
		dataType: 'json'
	});
	return false;
}	
	$('#search_input').bind('keyup', typeAheadCall);
	
	$('#search_input').parent('form').submit(function(e){
		rpc.getSelected(function(result){
			console.log('selected results?', result);
			if(result === false){
				typeAheadCall(e);
			}
		});
		return false;
	});
	
	$('#search_input').keydown(function(e){
		var $this = $(this);
		
		console.log("event keycode?", rpc, e, e.keycode, e.keyCode);
		
		if(e.keyCode === 40 || e.keyCode === 38){
			console.log("unbinding keyup from", $this);
			//$this.unbind('keyup');
		}
		
		if(e.keyCode === 40){
			//down arrow
			rpc.nextAutoSuggest();
		}
		
		if(e.keyCode === 38){
			//up arrow
			rpc.prevAutoSuggest();
		}
	});
	
	function tagSubmit(event){
		var $this = $(this)
				,$input = $(this).find('input.tags')
				,$container = $(this).find('#tag_container')
				,tags = $input.val().split(',')
				;
		$input.addClass('loading');
		$.ajax({
			url : "/bar/tag",
			type: "post",
			data: {
				url: window.name.split("||")[0]
				,title: window.name.split("||")[1]
				,tags: $input.val()
			},
			success :function(data){
				$input.removeClass('loading');
				//add tag inputs
				var i;
				for(i=0; i<tags.length; i++){
					var tag = tags[i].replace(/^\s+|\s+$/g, '')
							,$tag = $('<span style="display:none;"><input type="checkbox" name="tags" checked="checked" id="'+tag+'_tag" /><label>'+tag+'</label></span>')
							;
					$tag.appendTo($container);
					$tag.fadeIn('slow');
				}
			},
			dataType: 'json'
		});
		return false;
	}
	
	$("form.tag_form").live('submit',tagSubmit);
	
	
	$("#tag_container input").live('click',function(){
		var $this = $(this)
				,$container = $this.parent()
				,$label = $this.next()
				;
		$.ajax({
			url : "/bar/remove_tag",
			type: "post",
			data: {
				url: window.name.split("||")[0]
				,title: window.name.split("||")[1]
				,tag: $this.next('label').text()
			},
			success :function(data){
				$container.fadeOut('slow', function(){
					$container.remove();
				});
			},
			dataType: 'json'
		});
				
		return false;
	});
	
});