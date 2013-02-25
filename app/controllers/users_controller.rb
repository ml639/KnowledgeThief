class UsersController < ApplicationController
	def index
		if current_user
			#raise current_user.to_yaml
			#return current_user
			@rc = Resource.where(:user_id => current_user.id)
			@comments = Comment.where(:user_id => current_user.id)
		else
			redirect_to (home_path), :notice => "Please, log in." 
		end
	end

	def ajaxProfile
		if current_user
			#raise current_user.to_yaml
			#return current_user
			@rc = Resource.where(:user_id => current_user.id)
		else
			redirect_to (home_path), :notice => "Please, log in." 

		end
		render :partial => "profile"
	end
end