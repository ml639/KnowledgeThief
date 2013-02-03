var ResourceView = function(){
	
	var resource_id = 0;
	var isToggledUp = false;
	var currentPosition = 0;
  	var slideWidth = $(window).width();
  	var slideHeight = $(window).height();
  	var slides = $('.slide');
  	var numberOfSlides = slides.length
	init = function(url,new_resource_id){
		resource_id = new_resource_id;
		$("#slideshow").css({'width': slideWidth});
		$("#slidesContainer").css({'width': slideWidth});
		$("#slideshow").css({'height': slideHeight});
		$("#slidesContainer").css({'height': slideHeight});
		// Remove scrollbar in JS
  		$('#slidesContainer').css('overflow', 'hidden');
  		
  		// Hide left arrow control on first load
  		manageControls(currentPosition);
  		$('#home').bind('click', function(){
  			remove();
  		});
  		$('.control')
    		.bind('click', function(){
    		// Determine new position
      		currentPosition = ($(this).attr('id')=='nextslide') ? currentPosition+1 : currentPosition-1;
      		$(".colorChange").changeColors({
    			time: 333
			});
      		// Hide / show controls
      		manageControls(currentPosition);
      		// Move slideInner using margin-left
      		$('#slideInner').animate({
        	'marginLeft' : slideWidth*(-currentPosition)
      		},750);
    	});

    	var hrefs = new Array();
		$('.resourceTitle').each(function(){
  			hrefs.push($(this).find('a').attr('href'));
		});


		$.each(hrefs,function(index,value){
			var theIframe2 = document.createElement("iframe");	
			theIframe2.setAttribute("id", "main-iframe2");
			theIframe2.setAttribute("src", value);
			theIframe2.style.float = "left";
			theIframe2.style.height = "100%";
			theIframe2.style.width = "100%";
			theIframe2.style.border = "none";
			theIframe2.style.top = "-1000px";
			newSlide = $("<div class='slide'></div>").appendTo("#slidesContainer"); 
			$(newSlide).append(theIframe2);
		});
    	/* Initialize the iFrames */
		slides = $('.slide');
		slides
    		.wrapAll('<div id="slideInner"></div>')
    		// Float left to display horizontally, readjust .slides width
			.css({
      		'float' : 'left',
      		'height': slideHeight,
      		'width' : slideWidth
    	});
		numberOfSlides = hrefs.length
		// Set #slideInner width equal to total width of all slides
  		$('#slideInner').css('width', slideWidth * numberOfSlides);

		$("#slideshow").fadeIn("fast");
		$("#slidesContainer").fadeIn("fast");

		$('#contentColumn').fadeOut();
		$("#bar-wrap").animate(
		   {"right": "10px"},{
		     duration: 1000,
		     complete: function(){
		       	$("#fadeAway").fadeIn(1000);
		     }
		   });
	};
	$.fn.changeColors = function(userOptions){
		var randomColor = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
		// starting color, ending color, duration in ms
    	var options = $.extend({
        	start: "#FF0000",
        	end: randomColor,
       	 	time: 2000
    	}, userOptions || {});
    	$(this).animate({
        backgroundColor: options.end
    	}, options.time);
    	return this;
	};
	manageControls = function(position){
	// Hide left arrow if position is first slide
    if(position==0){ $('#leftControl').hide() }
    else{ $('#leftControl').show() }
    // Hide right arrow if position is last slide
    if(position==numberOfSlides-1){ $('#rightControl').hide() }
    else{ $('#rightControl').show() 
	}
	};
	toggleBar = function(){
		if(isToggledUp){
			$("#info-button").removeClass("toggled-a");
			$("#info-toggle").removeClass("toggled-bg")
			$("#bar-wrap").animate(
		  	 	{"top": "585px"},{
		     		duration: 500,
		     		complete: function(){   
		     	
		     	}
		   });
			isToggledUp = false;
		}else{
			$("#info-button").addClass("toggled-a");
			$("#info-toggle").addClass("toggled-bg")
			$("#bar-wrap").animate(
				{"top": "200px"},{
		     	duration: 500,
		     	complete: function(){
		       
		     }
		   });
			isToggledUp = true;
		}	
		
	}
	remove = function(){
		$("#slidesContainer").html('');   	
		$("#slideshow").fadeOut("fast");
		$("#slidesContainer").fadeOut("fast");
		$('#contentColumn').fadeIn();
	};
	
	comments = function(){
		$.ajax({
			type: "post",
			url: "comments/"+resource_id +"/forresource",
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				$.each(objResponse.comments, function(i, item) {
					  var today = new Date();
					  var post =item.updated_at;
					  //  date = Date.parse(DateToValue);
					  difference = (post-today)/(1000*60);
					  var timediff = 0;
					  if(difference < 60){
				        timediff = difference + " minutes ago";
			    	  }else if(difference < 1440 && difference >= 60){
					    timediff = difference/60 + " hours ago";
					  }else if(difference >= 1440){
					    timediff = difference/(60*24) + " days ago";
					  }
    				$('.commentsList').append("<li><div class='commentContent>'" +item.content +"</div><div class='commentInfo>" +timediff +"</div></li>");
				});
			},
			error: function( objRequest, strError ){
				alert("error with comment");
			}
		});
	}
	logUser = function(new_resource_id){
		$.ajax({
			type: "post",
			url: "userResourceView",
			data: {
				resource_id : new_resource_id
			},
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				if (objResponse.success){
				} else {
				}
			},
			error: function( objRequest, strError ){
				
			}
		});
	}
	saveComment = function(commentText){
		$.ajax({
			type: "post",
			url: "comments/",
			data: {
				content : commentText,
				resource : resource_id
			},
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				$('.commentsList').html('');
				$.each(objResponse.comments, function(i, item) {
    				$('.commentsList').append("<li>" +item.content +"</li>");
				});
			},
			error: function( objRequest, strError ){
				alert("error with comment");
			}
		});
	}
	vote = function(vote){
		$.ajax({
			type: "post",
			url: "resources/"+resource_id +"/vote",
			data: {
				type : vote
			},
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				if (objResponse.success){
					if(vote === 'up'){
						$('.upvote_image').attr('src',"/assets/circle_thumbsUp_here.png");
					}else{
						$('.downvote_image').attr('src',"/assets/circle_thumbsDown_here.png");
					}
				} else {
					alert("sucess1");
				}
			},
			error: function( objRequest, strError ){
				alert("Please login or create an account to vote");
			}
		});
	}
	return{
		init : init,
		remove : remove,
		comments : comments,
		vote : vote,
		logUser : logUser,
		saveComment : saveComment,
		toggleBar : toggleBar
	}
};

$(function(){
	var rView = new ResourceView()
	$('.resourceViewer').click(function(){
		var link = jQuery(this);
		var link_href = link.attr('href');
		var resource_id = link.attr('value');
	    rView.init(link_href, resource_id);
		rView.comments();
		rView.logUser(resource_id);
		return false
	});
	
	$(".ajaxUpvote").click(function(){
		rView.vote('up');
	});
	$(".ajaxDownvote").click(function(){
		rView.vote('down');
	});
	$('#saveComment').click(function(){
		var commentText = $("#commenttext").val();
		rView.saveComment(commentText);
	});

	$('#upvote').mouseover(function(){
          $(this).prev().slideDown(250);
          $(this).animate({opacity: 1}, 250);
       });
    
    $('#upvote').mouseout(function(){   
          $(this).prev().slideUp(250);
          $(this).animate({opacity: 0}, 250);
       });
    $('#downvote').mouseover(function(){
          $(this).prev().slideDown(250);
          $(this).animate({opacity: 1}, 250);
       });
    
    $('#downvote').mouseout(function(){   
          $(this).prev().slideUp(250);
          $(this).animate({opacity: 0}, 250);
       });

    $('#button-home').mouseover(function(){
          $(this).find('a').prev().slideDown(250);
          $(this).find('a').animate({opacity: 1}, 250);
       });
    
    $('#button-home').mouseout(function(){   
          $(this).find('a').prev().slideUp(250);
          $(this).find('a').animate({opacity: 0}, 250);
       });
    $('.navigation-box').click(function(event){
    	var clickedButtonId = event.target.id;
    	$('.navHere').slideUp(250, function() {
    		var oldActive = $('.navHere').attr('id');
    		switch (clickedButtonId) { 
        		case 'resourceNav-info': 
        			$('#information-box').slideDown(250);
        			$("#"+oldActive).removeClass('navHere');
					$('#information-box').addClass('navHere');
             		break;
             	case 'resourceNav-addQuestion': 
             		$('#questions-form').slideDown(250);
             		$("#"+oldActive).removeClass('navHere');
					$('#questions-form').addClass('navHere');
             		break; 
             	case 'resourceNav-addResource': 
             		$('#resource-form').slideDown(250);
             		$("#"+oldActive).removeClass('navHere');
					$('#resource-form').addClass('navHere');
             		break; 
             	case 'resourceNav-addPath': 
             		$('#path-form').slideDown(250);
             		$("#"+oldActive).removeClass('navHere');
					$('#path-form').addClass('navHere');
             		break;    
    		}
			 		
		});
    });
   /*  $('#resourceNav-info').mouseover(function(){
          $(this).find('div').slideDown(250);
          $(this).animate({opacity: 0}, 250);
           $('#nav-info-button').stop().animate({opacity: 1}, 250); 

       });
    
    $('#resourceNav-info').mouseout(function(){  
     	$(this).find('div').slideUp(250);
         $(this).animate({opacity: 1}, 250); 
         $('#nav-info-button').stop().animate({opacity: 0}, 250); 
         
       });*/
    
    $("#info-toggle").click(function(){
    	rView.toggleBar();
    });

});
