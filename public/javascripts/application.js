$(document).ready(function(){
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
				var $form =$('<form method="post" action="bar/tags" class="tag_form">\
					<input type="text" class="autobox tags" value="Add Tags" />\
				</form>');
				$this.after($form);
				$form.find('input.autobox').autobox();
				
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
	console.log("type ahead call", e);
	if(e.keyCode == 40 || e.keyCode == 38){
		//do not rebuild on up down
		return false;
	}
	
	var $this = $(this);
	$.ajax({
		url: "/bar/search",
		type: "post",
		data: {
			query: $this.val()
		},
		success: function(data){
			rpc.buildList(data);
		},
		error: function(){
			console.log("key up broke");
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
	
	$('#search_input').keypress(function(e){
		var $this = $(this);
		
		console.log("event keycode?", rpc, e, e.keycode, e.keyCode);
		
		if(e.keyCode == 40 || e.keyCode == 38){
			console.log("unbinding keyup from", $this);
			//$this.unbind('keyup');
		}
		
		if(e.keyCode == 40){
			//down arrow
			rpc.nextAutoSuggest();
			//$this.bind('keyup', typeAheadCall);
		}
		
		if(e.keyCode == 38){
			//up arrow
			rpc.prevAutoSuggest();
			//$this.bind('keyup', typeAheadCall);
		}
	});
	
});