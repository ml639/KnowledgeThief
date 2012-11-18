var ResourceView = function(){
	 var theIframe2 = document.createElement("iframe");
	init = function(url){
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

	return{
		init : init,
		remove : remove,
		comments : comments
	}
};

$(function(){
	var rView = new ResourceView()
	$('.resourceViewer').click(function(){
		var link = jQuery(this);
		var link_href = link.attr('href');
	    rView.init(link_href);
		rView.comments();
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
});