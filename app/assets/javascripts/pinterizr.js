var Pinterizr = function () {
	init = function(url,new_resource_id){
		setKeyBindings();
	},
	setKeyBindings = function(){
		$(".pin").hover(
		  function () {
		    $(this).find(".resourceButtons").stop().animate({
		        opacity: 1
		    	}, 250);
		  },
		  function () {
		    $(this).find(".resourceButtons").stop().animate({
		        opacity: 0
		    	}, 250);
		  }
		);
		$('.pin').click(function(e) {
			modalSetup(e);
			var link = $(this).find('a').attr('href');
			//this is hacky as shit. split on /'s and check if its a resource link
			var parts = link.split('/');
			if(parts[1] == "resources"){
				return true;
			}else{
				var link_href = link;
				var get_resource_id = $(this).attr('value');
				loadModalContents(link,get_resource_id);
			}
		});
		$('.window .close').click(function (e) {
			modalClose(e);
		});
		//if mask is clicked
		$('#mask').click(function () {
			$(this).hide();
			$('.window').hide();
		});		

		$(window).resize(function () {
	 	modalResize();
		});
	},
	loadModalContents = function(url,new_resource_id){
		$.ajax({
			type: "get",
			url: "/resources/"+new_resource_id,
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				alert(objResponse.resource);
				if(true){
					
				}
			},
			error: function( objRequest, strError ){
				//alert("error loading content");
			}
		});
	},
	modalSetup = function(e){
		//Cancel the link behavior
		e.preventDefault();
		
		//Get the A tag
		var id = '#dialog';
	
		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
	
		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		
		//transition effect		
		$('#mask').fadeIn(1000);	
		$('#mask').fadeTo("slow",0.8);	
	
		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();
              
		//Set the popup window to center
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
	
		//transition effect
		$(id).fadeIn(700); 
	},
	modalResize = function(){

 		var box = $('#boxes .window');
 
        //Get the screen height and width
        var maskHeight = $(document).height();
        var maskWidth = $(window).width();
      
        //Set height and width to mask to fill up the whole screen
        $('#mask').css({'width':maskWidth,'height':maskHeight});
               
        //Get the window height and width
        var winH = $(window).height();
        var winW = $(window).width();

        //Set the popup window to center
        box.css('top',  winH/2 - box.height()/2);
        box.css('left', winW/2 - box.width()/2);
	},
	modalClose = function(e){
		//Cancel the link behavior
		e.preventDefault();
		$('#mask').hide();
		$('.window').hide();
	}
	return{
		init : init
	};
};
$(function(){
	var pinterest = new Pinterizr();
	
	$(".pin").hover(
		  function () {
		    $(this).find(".resourceButtons").stop().animate({
		        opacity: 1
		    	}, 250);
		  },
		  function () {
		    $(this).find(".resourceButtons").stop().animate({
		        opacity: 0
		    	}, 250);
		  }
		);
});
