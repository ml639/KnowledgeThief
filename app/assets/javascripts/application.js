//= require engage
//= require jquery_cookies
//
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .



$(document).ready(function()
{
  //Handles menu drop down
  $('.dropdown-menu').find('form').click(function (e) {
        e.stopPropagation();
        });
  });

$(document).ready(function(){
	var loginIsDown = false;
	var registerIsDown = false;
	$('#login-trigger').click(function(){
		if(!registerIsDown){
		$(this).next('#login-content').slideToggle();
		loginIsDown = !loginIsDown;
		$(this).toggleClass('active');					

		if ($(this).hasClass('active')) $(this).find('span').html('&#x25B2;')
			else $(this).find('span').html('&#x25BC;')
		}
		});
		
	$('#register-trigger').click(function(){
		if(!loginIsDown){
		$(this).next('#register-content').slideToggle();
		registerIsDown = !registerIsDown;
		$(this).toggleClass('active');					

		if ($(this).hasClass('active')) $(this).find('span').html('&#x25B2;')
			else $(this).find('span').html('&#x25BC;')
		}
		});
});

$(function(){
		$('.slide-out-div').tabSlideOut({
	       tabHandle: '.handle',                     //class of the element that will become your tab
	       pathToTabImage: 'assets/comments.png', //path to the image for the tab //Optionally can be set using css
	       imageHeight: '120px',                     //height of tab image           //Optionally can be set using css
	       imageWidth: '20px',                       //width of tab image            //Optionally can be set using css
	       tabLocation: 'right',                      //side of screen where tab lives, top, right, bottom, or left
	       speed: 300,                               //speed of animation
	       action: 'click',                          //options: 'click' or 'hover', action to trigger animation
	       topPos: '200px',                          //position from the top/ use if tabLocation is left or right
	       leftPos: '20px',                          //position from left/ use if tabLocation is bottom or top
	       fixedPosition: false                      //options: true makes it stick(fixed position) on scroll
	   });	
});


