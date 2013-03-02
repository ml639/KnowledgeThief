/* jquery page loader for our profile content. */
var PageLoader = function(){
	var currentPosition = 1;
  	var slideWidth = $(window).width();
  	var slideHeight = $(window).height();
  	var slides = $('.contentSlide');
  	var numberOfSlides = slides.length;
  	var slideShow = $("#contentSlideShow");
  	var slidesContainer = $("#contentSlidesContainer");
	var initialURL = location.href;
	var currentURL = location.href;
	init = function(){
		setPageBindings();
		slideShow.css({'width': slideWidth});
		slidesContainer.css({'width': slideWidth});
		// Remove scrollbar in JS
  		slidesContainer.css('overflow', 'hidden');
  		slides
    		.wrapAll('<div id="contentInner"></div>')
    		// Float left to display horizontally, readjust .slides width
			.css({
      		'float' : 'left',
      		'min-height': slideHeight,
      		'width' : slideWidth
    	});
		$('#contentInner').css("marginLeft", -slideWidth);
		adjustHeight();
	},
	adjustHeight = function(){
		var tempHeight = 900;
		switch (currentPosition) {
    		case 0:
    			tempHeight = $('#pathSlide').children('.container').height();
         		break;
         	case 1:
         		tempHeight = $('#homeSlide').children('.container').height();
         		break;
         	case 2:
         		tempHeight = $('#profileSlide').children('.container').height();
         		break;
		};
		slides.css({'height': tempHeight});
		slidesContainer.css({'height': tempHeight});
		slideShow.css({'height': tempHeight});
		$('#contentInner').css("height", tempHeight);
	},
	updateBrowser = function(url){
		window.history.isPageLoader = true; // set a variable in our history we can check for during a popstate event. 
		window.history.isResource = false; // set a variable in our history we can check for during a popstate event.  
		window.history.pushState({isPageLoader: true, isResource : false}, "pageLoaderEvent", url);
	},
	setPageBindings = function(){
		
		$(window).bind('popstate', function (ev){
			var popped = window.history.state != null;
			var initialPop = !popped && currentURL == initialURL;
	  		popped = true;
			if ( initialPop ) return;
  			if (window.history.isPageLoader && ev.originalEvent.state == null){
  				// If a popstate occurs, check to see if we're in a resource, if so, remove the iframe, else, do nothing.
  				// if the originalEvent.state is false, then we know we're returning to the original page.
  				// Fucking wack shit.
  				currentPosition--;
  				switch (currentPosition) {
	    		case 0:
	    			showPaths();
	         		break;
	         	case 1:
	         		showHome();
	         		break;
	         	case 2:
	         		showProfile();
	         		break;
				};
  			}else{
  				 if(ev.originalEvent.state.isPageLoader){
  				currentPosition--;
  				switch (currentPosition) {
	    		case 0:
	    			showPaths();
	         		break;
	         	case 1:
	         		showHome();
	         		break;
	         	case 2:
	         		showProfile();
	         		break;
				};
  			}
  			}
		});
		$("#profileLink").click(function() {
			updateBrowser("/user_profile");
			
			showProfile();
			
			return false;
		});
		$("#homeLink").click(function(){
			updateBrowser("/");
			showHome();
			
			return false;
		});
		$("#pathsLink").click(function(){
			updateBrowser("/paths");
			showPaths();
			
			return false;
		});
	},
	slideToLeft = function(slideDistance){
		$("#contentInner").animate(
   			{"marginLeft": slideWidth*(-slideDistance)},{
     		duration: 750,
     		complete: function(){
		    }
		});
		manageArrows();
	},
	slideToRight = function(slideDistance){
		$("#contentInner").animate(
   			{"marginLeft": slideWidth*(-slideDistance)},{
     		duration: 750,
     		complete: function(){
		    }
		});
		manageArrows();
	},
	manageArrows = function(){
		if(currentPosition === 2){
			$('#rightArrow').animate(
				{'opacity': 0},
				{duration: 500
			});
		}
		if(currentPosition === 0){
			$('#leftArrow').animate(
				{'opacity': 0},
				{duration: 500
			});
		}
		if(currentPosition != 0){
			$('#leftArrow').animate(
				{'opacity': 1},
				{duration: 500
			});
		}
		if(currentPosition != 2){
			$('#rightArrow').animate(
				{'opacity': 1},
				{duration: 500
			});
		}
	},
	showProfile = function(){
		//newSlide = $("<div class='contentSlide'></div>").appendTo('#contentInner');
		
		currentURL = location.href;
		if(currentPosition === 2){
			return false;
		}else{
			$('#profileSlide').load('/ajaxProfile');
			currentPosition = 2;
	  		updateSlideShow();
	  		adjustHeight();
	  		$("#profileLink").addClass("active");
	  		$("#homeLink").removeClass("active");
	  		$('#pathsLink').removeClass("active");
	  		slideToRight(2);
		}
		return false;
	},
	showPaths = function(){
		//newSlide = $("<div class='contentSlide'></div>").appendTo('#contentInner');
		
		currentURL = location.href;
		if(currentPosition === 0){
			return false;
		}else{
			$('#pathSlide').load('/ajaxPaths');
	  		updateSlideShow();
	  		currentPosition = 0;
	  		adjustHeight();
	  		$("#profileLink").removeClass("active");
	  		$("#homeLink").removeClass("active");
	  		$('#pathsLink').addClass("active");
	  		slideToLeft(0);
		}
		return false;
	},
	showHome = function(){
		
		currentURL = location.href;
		if(currentPosition === 2){
			currentPosition = 1;
			adjustHeight();
			slideToLeft(1);
		}else if(currentPosition ===0){
			currentPosition = 1;
			adjustHeight();
			slideToRight(1);
		}else{
			return false;
		}
		$("#profileLink").removeClass("active");
  		$("#homeLink").addClass("active");
  		$('#pathsLink').removeClass("active");
	},
	updateSlideShow = function(){
		slides.css({
      		'float' : 'left',
      		'width' : slideWidth
    	});
		numberOfSlides = slides.length
		// Set #slideInner width equal to total width of all slides
  		$('#slideInner').css('width', slideWidth * numberOfSlides);
	}
	return{
		init : init
	};
};
$(function(){
	//var pageLoader = new PageLoader();
	//pageLoader.init();
})