
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
