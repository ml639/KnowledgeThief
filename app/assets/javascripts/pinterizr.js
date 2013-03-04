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
		$('.path_bttn').click(function(e) {
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
		$('#boxes').click(function () {
			$('#mask').hide();
			$('#boxes').hide();
			$('body').removeClass('body-locked');
		});		
		$(".modalPin").click(function(){
			return;
		});
		$(window).resize(function () {
	 	modalResize();
		});
		// $(window).scroll(function() {
  //   			if($(window).scrollTop() + $(window).height() == $(document).height()) {
  //      			  scroll();
  //  			}
		//  });
	},
	//loadModalContents = function(url,new_resource_id){
	//	$.ajax({
	//		type: "get",
	//		url: "/resources/"+new_resource_id,
	//		dataType: "json",
			// Define request handlers.
	//		success: function( objResponse ){
				// Check to see if request was successful.
	//			$(".modalUpvotesCount").append(objResponse.reputation);
	//			$(".modalResourceTitle").append(objResponse.resource.title);
	//			$(".modalResourceDescription").append(objResponse.resource.description);
	//		},
	//		error: function( objRequest, strError ){
				//alert("error loading content");
	//		}
	//	});
	//},
	modalSetup = function(e){
		//Cancel the link behavior
		e.preventDefault();
		$('body').addClass('body-locked');
		//Get the A tag
		var id = '#boxes';
	
		//Get the screen height and swidth
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
	
		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		
		//transition effect		
		$('#mask').fadeIn(1000);	
		$('#mask').fadeTo("slow",0.8);	
	
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
  
	},
	scroll  = function(){  
			$.getScript('/infiniteScroll', function(){
					alert("finished");
					x= 1;
			});

	   //  	$.ajax({
				// type: "get",
				// url: "/infiniteScroll",
				// data: {
				// 	offset : 10
				// },
				// dataType: "json",
				// // Define request handlers.
				// success: function( objResponse ){
				// 	// Check to see if request was successful.
				// 	if (objResponse.success){
				// 		$.each(objResponse.resources, function(i, item) {
    // 						$('.columns').hide().append("<div class='pin' value='" +item.id+"'>" 
    // 							+"<div class='resourceButtons'><button>Paths</button></div>"
    // 							+"<div class='resourceContentHolder'>"
    // 						).fadeIn();
				// 		});
				// 	} else {
				// 	}
				// },
				// error: function( objRequest, strError ){

				// }
			//});
	},
	modalClose = function(e){
		//Cancel the link behavior
		
		e.preventDefault();
		$('body').removeClass('body-locked');
		$('#mask').hide();
		$('#boxes').hide();
	}
	return{
		init : init,
		scroll : scroll
	};
};
$(function(){
	var pinterest = new Pinterizr();
	//pinterest.init();
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
