var ResourceView = function(){
	 var theIframe2 = document.createElement("iframe");
	 var resource_id = 0;
	init = function(url,new_resource_id){
		resource_id = new_resource_id;
		theIframe2.setAttribute("id", "main-iframe2");
		theIframe2.setAttribute("src", url);
		theIframe2.style.width = "100%";
		theIframe2.style.height = "100%";
		theIframe2.style.border = "none";
		theIframe2.style.top = "-1000px";
		var containerDiv2 = document.getElementById('wrapper');
		$("#frameHolder").append(theIframe2);
		$("#frameHolder").fadeIn("fast");
		//containerDiv2.appendChild(theIframe2);
		$("#resourceViewMenu").fadeIn("fast");
		$("#resourceViewMenu").animate(
			   {"top": "0px"},"slow");
		$('#contentColumn').fadeOut();
		 $("#main-iframe2").animate(
		   {"top": "58px"},"slow");
	};
	remove = function(){
		$("#main-iframe2").animate(
		   {"top": "-1000px"},"slow");
		theIframe2.parentNode.removeChild(theIframe2);    	
	};
	
	comments = function(){
		$('.slide-out-div').fadeIn("slow");
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
		logUser : logUser
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
		rView.logUser();
		return false
	});
	$('#home_Button').click(function(){
		rView.remove();
		$("#frameHolder").fadeOut("fast");
		$('#contentColumn').fadeIn();
		$("#resourceViewMenu").animate(
			   {"top": "-50px"},"slow");
		$("#resourceViewMenu").fadeOut();
		$('.slide-out-div').fadeOut("slow");
	});
	
	$(".ajaxUpvote").click(function(){
		rView.vote('up');
	});
	$(".ajaxDownvote").click(function(){
		rView.vote('down');
	});
});