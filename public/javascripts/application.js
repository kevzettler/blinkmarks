$(document).ready(function(){
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
				console.log('success call back', data);
				$this.text('Remove from favorites');
				$this.removeClass('add');
				$this.addClass('remove');
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
				console.log("successfull delete");
				$this.text('Add to favorites');
				$this.removeClass('remove');
				$this.addClass('add');
			},
			dataType: 'json'
		});
		return false;
	});
	
});