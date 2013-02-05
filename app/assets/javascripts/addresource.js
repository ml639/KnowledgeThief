var AddResource = function(){

	init = function(){
		if($('.addNewQuestionForm').css('display') != 'none'){
			$('.addNewQuestionForm').slideUp(400, function(){
			$('.addNewResourceForm').slideDown(400);
		});
		}else{
			$('.bottomWrapper').slideUp(400, function(){
				$('.addNewResourceForm').slideDown(400);
			});	
		}
	};
	remove = function(){
		$('.addNewResourceForm').slideUp(400, function(){
			$('.bottomWrapper').slideDown(400);
		});
	};
	return{
		init: init,
		remove: remove
	};
};
$(function(){
	var addResource = new AddResource();
	$('.addResource').click(function(){
		addResource.init();
		return false;
	});
	$('.cancelButton').click(function(){
		addResource.remove();
		return false;
	});
});