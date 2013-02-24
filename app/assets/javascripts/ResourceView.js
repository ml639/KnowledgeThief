var ResourceView = function(){
	var resource_id = 0;
	var isToggledUp = false;
	var currentPosition = 0;
  	var slideWidth = $(window).width();
  	var slideHeight = $(window).height();
  	var slides = $('.slide');
  	var numberOfSlides = slides.length;
    var searchResultURLS = new Array();
    var iFrameURLS = new Array();
	init = function(url,new_resource_id){
		resource_id = new_resource_id;
		$('#slidesContainer').css('overflow', 'hidden');
		slideWidth = $(window).width();
		$("#slideshow").css({'width': slideWidth});
		$("#slidesContainer").css({'width': slideWidth});
		$("#slideshow").css({'height': slideHeight});
		$("#slidesContainer").css({'height': slideHeight});
		// Remove scrollbar in JS
  		
  		setKeyBindings();
  		slideWidth = $(window).width();
		$('.resourceThumb').each(function(){
  			searchResultURLS.push($(this).find('a').attr('href'));
		});
		var isFirst = true;
		for(var i = 0 ; i< searchResultURLS.length; i++){
			if(searchResultURLS[i] === url){
				if(i != 0){//load the page before the current click.
					var prevIframe = document.createElement("iframe");
					prevIframe.setAttribute("id", "main-iframe2");
					prevIframe.setAttribute("src", searchResultURLS[i-1]);
					prevIframe.style.float = "left";
					prevIframe.style.height = "100%";
					prevIframe.style.width = "100%";
					prevIframe.style.border = "none";
					prevIframe.style.top = "-1000px";
					newSlide = $("<div class='slide'></div>").appendTo("#slidesContainer");
					$(newSlide).append(prevIframe);
					isFirst = false;
					iFrameURLS.push(searchResultURLS[i-1]);
				}
				//load the current click
				var tempIFrame = document.createElement("iframe");
				tempIFrame.setAttribute("id", "main-iframe2");
				tempIFrame.setAttribute("src", searchResultURLS[i]);
				tempIFrame.style.float = "left";
				tempIFrame.style.height = "100%";
				tempIFrame.style.width = "100%";
				tempIFrame.style.border = "none";
				tempIFrame.style.top = "-1000px";
				newSlide = $("<div class='slide'></div>").appendTo("#slidesContainer");
				$(newSlide).append(tempIFrame);
				iFrameURLS.push(searchResultURLS[i]);
				if(i < searchResultURLS.length-1){
					var nextIFrame = document.createElement("iframe");
					nextIFrame.setAttribute("id", "main-iframe2");
					nextIFrame.setAttribute("src", searchResultURLS[i+1]);
					nextIFrame.style.float = "left";
					nextIFrame.style.height = "100%";
					nextIFrame.style.width = "100%";
					nextIFrame.style.border = "none";
					nextIFrame.style.top = "-1000px";
					newSlide = $("<div class='slide'></div>").appendTo("#slidesContainer");
					$(newSlide).append(nextIFrame);
					iFrameURLS.push(searchResultURLS[i+1]);
				}
				break;
			}
		}
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
		numberOfSlides = slides.length
		// Set #slideInner width equal to total width of all slides
  		$('#slideInner').css('width', slideWidth * numberOfSlides);
  		if(!isFirst){
  			$('#slideInner').css('marginLeft', -slideWidth);
  			currentPosition++;
  		}

		$("#slideshow").fadeIn("fast");
		$("#slidesContainer").fadeIn("fast");
		$('#contentWrapper').fadeOut();
		$('#header').fadeOut();
		$("#bar-wrap").animate(
		   {"right": "10px"},{
		     duration: 1000,
		     complete: function(){
		     	cleanup();
		       	setTimeout(function() {
		    		if(!isToggledUp){
					 $('#navCollapse').stop().fadeOut();
					 }
					}, 3000 );
		     }
		   });
	};
	cleanup = function(){
		slideWidth = $(window).width();
		$("#slideshow").css({'width': slideWidth});
		$("#slidesContainer").css({'width': slideWidth});
		$('#slideInner').css('width', slideWidth * numberOfSlides);
  		$('#slideInner').css('marginLeft', -slideWidth);
  		$('.slide').css({
      		'width' : slideWidth
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
	setKeyBindings = function(){

	    $('#info-button').mouseover(function(){
	          $('#navCollapse').fadeIn();
	       });
	    $('#bar-wrap').mouseleave(function(){
	    	setTimeout(function() {
	    		if(!isToggledUp){
					 $('#navCollapse').stop().fadeOut();
						 }
						}, 3000 );
	       });
		$('#home').click(function(){
  			removeBar();
  		});
  		$('.control')
    		.bind('click', function(){
    		// Determine new position
    		var isNext  = ($(this).attr('id')=='nextslide') ? true : false;
    		if(currentPosition == 0  && !isNext)
    			return false;
    		else if(currentPosition == numberOfSlides-1 && isNext)
    			return false;
    		else{
    			currentPosition = ($(this).attr('id')=='nextslide') ? currentPosition+1 : currentPosition-1;
	      		$(".colorChange").changeColors({
	    			time: 333
				});
	      		// Hide / show controls

	      		// Move slideInner using margin-left
	      		$("#slideInner").animate(
		   			{"marginLeft": slideWidth*(-currentPosition)},{
		     		duration: 750,
		     		complete: function(){
		       			manageIframes(currentPosition);
				     }
				   });
    		}
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
		$(".ajaxUpvote").click(function(){
			vote('up');
		});
		$(".ajaxDownvote").click(function(){
			vote('down');
		});
		$('#saveComment').click(function(){
			var commentText = $("#commenttext").val();
			saveComment(commentText);
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
	};
	manageIframes = function(position){
		//check the current position and load the next iframe if possible.
		var currentLink = iFrameURLS[position];
		var new_res_id = $('a[href$="'+currentLink+'"]').parent().attr('value');
		resource_id = new_res_id;
		comments(resource_id);
    	if(position==0){
    		$('#leftControl').hide()
    	}else if(position == numberOfSlides-1){
    		var indexOfUrl = searchResultURLS.indexOf(iFrameURLS[position]);
    		var tempIFrame = document.createElement("iframe");
				tempIFrame.setAttribute("id", "main-iframe2");
				tempIFrame.setAttribute("src", searchResultURLS[indexOfUrl+1]);
				tempIFrame.style.float = "left";
				tempIFrame.style.height = "100%";
				tempIFrame.style.width = "100%";
				tempIFrame.style.border = "none";
				tempIFrame.style.top = "-1000px";
				newSlide = $("<div class='slide'></div>").appendTo("#slideInner");
				$(newSlide).append(tempIFrame);
				iFrameURLS.push(searchResultURLS[indexOfUrl+1]);
    	}
    	/* Initialize the iFrames */
		slides = $('.slide');
		slides.css({
      		'float' : 'left',
      		'height': slideHeight,
      		'width' : slideWidth
    	});
		numberOfSlides = slides.length
		// Set #slideInner width equal to total width of all slides
  		$('#slideInner').css('width', slideWidth * numberOfSlides);
	};
	toggleBar = function(){
		if(isToggledUp){
			$("#info-button").removeClass("toggled-a");
			$("#info-toggle").removeClass("toggled-bg")
			$("#bar-wrap").animate(
		  	 	{"bottom": "-340px"},{
		     		duration: 500,
		     		complete: function(){

		     	}
		   });
			isToggledUp = false;
		}else{
			$("#info-button").addClass("toggled-a");
			$("#info-toggle").addClass("toggled-bg");
			$("#bar-wrap").animate(
				{"bottom": "10px"},{
		     	duration: 500,
		     	complete: function(){
		     }
		   });
			isToggledUp = true;
		}
	};
	removeBar = function(){
		$("#slidesContainer").html('');
		$("#slideshow").fadeOut("fast");
		$("#slidesContainer").fadeOut("fast");
		$('#contentWrapper').fadeIn();
		$('#header').fadeIn();
		resource_id = 0;
		if(isToggledUp == true){
			toggleBar();
		}
		$("#bar-wrap").animate(
		   {"right": "-5000px"},{
		     duration: 1000,
		     complete: function(){
		       	$("#fadeAway").fadeIn(1000);
		     }
		   });
		currentPosition = 0;
		numberOfSlides = 0;

	};

	comments = function(new_resource_id){
		$.ajax({
			type: "post",
			url: "/comments/"+new_resource_id +"/forresource",
			dataType: "json",
			// Define request handlers.
			success: function( objResponse ){
				// Check to see if request was successful.
				$('.commentsList').empty();
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

    				$('.commentsList').append("<li>" +item.content +timediff +"  minutes ago</li>").hide().fadeIn();
				});
			},
			error: function( objRequest, strError ){
				alert("error with comment");
			}
		});
	};
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
	};
	saveComment = function(commentText){
		$.ajax({
			type: "post",
			url: "/comments/",
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
    				$('.commentsList').append("<li>" +item.content +"</li>").hide().fadeIn();
				});
			},
			error: function( objRequest, strError ){
				alert("error with comment");
			}
		});
	};
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
					alert("Thanks for voting!");
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
	};
	return{
		init : init,
		removeBar : removeBar,
		comments : comments,
		vote : vote,
		logUser : logUser,
		saveComment : saveComment,
		toggleBar : toggleBar
	};
};

$(function(){
	var rView = new ResourceView();
	$('.resourceThumb').click(function(){
		var link = $(this).find('a').attr('href')
		//this is hacky as shit. split on /'s and check if its a resource link
		var parts = link.split('/');
		if(parts[1] == "resources"){
			return true;
		}else{
			var link_href = link;
			var get_resource_id = $(this).attr('value');
	    	rView.init(link_href, get_resource_id);
			rView.comments(get_resource_id);
			rView.logUser(get_resource_id);
			return false;
		}
	});
	$("#info-toggle").click(function(e){
	    	 if( e.target.tagName.toUpperCase() !== 'INPUT' ) {
	    	 	rView.toggleBar();
	    	 }
	    });

});
