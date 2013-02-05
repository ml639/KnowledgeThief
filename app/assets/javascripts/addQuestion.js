var AddQuestion = function(){

	init = function(){
		if($('.addNewResourceForm').css('display') != 'none'){
			$('.addNewResourceForm').slideUp(400, function(){
			$('.addNewQuestionForm').slideDown(400);
		});
		}else{
			$('.bottomWrapper').slideUp(400, function(){
				$('.addNewQuestionForm').slideDown(400);
			});	
		}
	};
	remove = function(){
		$('.addNewQuestionForm').slideUp(400, function(){
			$('.bottomWrapper').slideDown(400);
		});
	};
	return{
		init: init,
		remove: remove
	};
};
$(function(){
	var addQuestion = new AddQuestion();
	$('.addQuestion').click(function(){
		addQuestion.init();
		return false;
	});
	$('.cancelButton').click(function(){
		addQuestion.remove();
		return false;
	});
});