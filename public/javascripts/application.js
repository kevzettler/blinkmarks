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


function typeAheadCall(){
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
	
	$('#search_input').keyup(typeAheadCall);
	$('#search_input').parent('form').submit(typeAheadCall);
	
	$('#search_input').keypress(function(e){
		console.log("event keycode?", e.keycode, e.keyCode);
		if(e.keyCode == 40){
			//down arrow
			rpc.nextAutoSuggest();
		}
		
		if(e.keyCode == 38){
			//up arrow
			rpc.previousAutoSuggest();
		}
	});
	
});